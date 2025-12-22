package com.tour.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;
import javax.websocket.OnClose;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

// Định nghĩa địa chỉ nhận sóng là /ws
@ServerEndpoint("/ws")
public class TourSocket {

    // Danh sách lưu tất cả các người dùng đang kết nối
    private static Set<Session> users = Collections.synchronizedSet(new HashSet<>());

    @OnOpen
    public void onOpen(Session session) {
        users.add(session); // Có người mới vào -> Thêm vào danh sách
        System.out.println("New connection: " + session.getId());
    }

    @OnClose
    public void onClose(Session session) {
        users.remove(session); // Người dùng thoát -> Xóa khỏi danh sách
    }

    // Hàm này dùng để gửi thông báo cho TẤT CẢ mọi người
    public static void broadcast(String message) {
        for (Session session : users) {
            try {
                if (session.isOpen()) {
                    session.getBasicRemote().sendText(message);
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}