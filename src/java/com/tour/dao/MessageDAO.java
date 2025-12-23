package com.tour.dao;

import com.tour.model.Message;
import com.tour.utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MessageDAO {

    // 1. Lưu tin nhắn mới
    public void saveMessage(int senderId, int receiverId, String content) {
        String query = "INSERT INTO Messages (sender_id, receiver_id, content) VALUES (?, ?, ?)";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            ps.setString(3, content);
            ps.executeUpdate();
        } catch (Exception e) { e.printStackTrace(); }
    }

    // 2. Lấy lịch sử chat giữa 2 người (Sắp xếp theo thời gian)
    public List<Message> getConversation(int userId1, int userId2) {
        List<Message> list = new ArrayList<>();
        // Lấy tin nhắn chiều A->B HOẶC B->A
        String query = "SELECT * FROM Messages WHERE (sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?) ORDER BY sent_at ASC";
        try {
            Connection conn = new DBContext().getConnection();
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, userId1);
            ps.setInt(2, userId2);
            ps.setInt(3, userId2);
            ps.setInt(4, userId1);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Message(
                    rs.getInt("message_id"),
                    rs.getInt("sender_id"),
                    rs.getInt("receiver_id"),
                    rs.getString("content"),
                    rs.getTimestamp("sent_at")
                ));
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }
}