package com.tour.controller;

import com.tour.dao.MessageDAO;
import com.tour.dao.UserDAO; // Import UserDAO
import com.tour.model.User;  // Import User Model
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

@ServerEndpoint("/chat") 
public class ChatSocket {

    private static Map<Integer, Session> userSessions = Collections.synchronizedMap(new HashMap<>());

    @OnOpen
    public void onOpen(Session session) {
        String query = session.getQueryString();
        if (query != null && query.contains("userId=")) {
            try {
                int userId = Integer.parseInt(query.split("=")[1]);
                userSessions.put(userId, session);
            } catch (Exception e) { e.printStackTrace(); }
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            // Format nhận từ Client: SENDER_ID:RECEIVER_ID:CONTENT
            String[] parts = message.split(":", 3);
            if (parts.length < 3) return;

            int senderId = Integer.parseInt(parts[0]);
            int receiverId = Integer.parseInt(parts[1]);
            String content = parts[2];

            // 1. Lưu vào Database
            MessageDAO msgDao = new MessageDAO();
            msgDao.saveMessage(senderId, receiverId, content);

            // 2. Lấy tên người gửi để làm thông báo
            UserDAO userDao = new UserDAO();
            User sender = userDao.getUserById(senderId);
            String senderName = (sender != null) ? sender.getFullName() : "Ai đó";

            // 3. Gửi cho người nhận (Nếu online)
            Session receiverSession = userSessions.get(receiverId);
            if (receiverSession != null && receiverSession.isOpen()) {
                // Format gửi đi: SENDER_ID:SENDER_NAME:CONTENT
                receiverSession.getBasicRemote().sendText(senderId + ":" + senderName + ":" + content);
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        userSessions.values().remove(session);
    }
    
    @OnError
    public void onError(Session session, Throwable error) {
        error.printStackTrace();
    }
}