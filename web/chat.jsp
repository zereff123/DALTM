<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chat với ${partner.fullName}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        /* CSS Chat Bubble */
        body { background-color: #f0f2f5; font-family: 'Segoe UI', sans-serif; }
        .chat-container { max-width: 600px; margin: 30px auto; background: white; border-radius: 15px; box-shadow: 0 5px 15px rgba(0,0,0,0.1); overflow: hidden; display: flex; flex-direction: column; height: 85vh; }
        .chat-header { background: #0084ff; color: white; padding: 15px; display: flex; align-items: center; box-shadow: 0 2px 5px rgba(0,0,0,0.1); z-index: 10; }
        .chat-box { flex: 1; overflow-y: auto; padding: 20px; display: flex; flex-direction: column; background: #fff; gap: 10px; scroll-behavior: smooth; }
        
        .message { max-width: 75%; padding: 10px 15px; border-radius: 18px; font-size: 0.95rem; word-wrap: break-word; position: relative; line-height: 1.4; }
        .message.sent { align-self: flex-end; background: #0084ff; color: white; border-bottom-right-radius: 2px; }
        .message.received { align-self: flex-start; background: #f0f0f0; color: #050505; border-bottom-left-radius: 2px; }
        
        .chat-input { padding: 15px; border-top: 1px solid #eee; display: flex; gap: 10px; background: #f9f9f9; }
        .btn-send { border-radius: 50%; width: 45px; height: 45px; display: flex; align-items: center; justify-content: center; transition: 0.2s; }
        .btn-send:hover { transform: scale(1.1); }
    </style>
</head>
<body>

    <div class="chat-container">
        <div class="chat-header">
            <a href="javascript:history.back()" class="text-white me-3"><i class="fas fa-arrow-left"></i></a>
            <div class="d-flex align-items-center">
                <div class="bg-white text-primary rounded-circle d-flex justify-content-center align-items-center me-2" style="width: 40px; height: 40px;">
                    <i class="fas fa-user fw-bold"></i>
                </div>
                <div>
                    <div class="fw-bold">${partner.fullName}</div>
                    <small class="opacity-75" style="font-size: 0.8rem;">
                        <span class="badge bg-success rounded-circle p-1" style="width: 8px; height: 8px; display: inline-block;"></span> Đang hoạt động
                    </small>
                </div>
            </div>
        </div>

        <div class="chat-box" id="chatBox">
            <c:forEach items="${history}" var="m">
                <c:choose>
                    <c:when test="${m.senderId == sessionScope.account.id}">
                        <div class="message sent">${m.content}</div>
                    </c:when>
                    <c:otherwise>
                        <div class="message received">${m.content}</div>
                    </c:otherwise>
                </c:choose>
            </c:forEach>
        </div>

        <div class="chat-input">
            <input type="text" id="msgInput" class="form-control rounded-pill border-0 shadow-sm" placeholder="Nhập tin nhắn..." onkeypress="handleEnter(event)">
            <button class="btn btn-primary btn-send shadow-sm" onclick="sendMessage()"><i class="fas fa-paper-plane"></i></button>
        </div>
    </div>

    <script>
        var myId = ${sessionScope.account.id};
        var partnerId = ${partner.id};
        
        // --- 1. KẾT NỐI WEBSOCKET ---
        // Đảm bảo IP đúng với máy server (Laptop của bạn)
        var socket = new WebSocket("ws://10.15.73.207:8080/TourRealtimeSystem/chat?userId=" + myId);

        socket.onopen = function() { 
            console.log("✅ Đã kết nối vào hệ thống Chat với ID: " + myId); 
        };

        // --- 2. NHẬN TIN NHẮN TỪ NGƯỜI KHÁC ---
        socket.onmessage = function(event) {
            var msg = event.data; 
            // Format MỚI: SENDER_ID:SENDER_NAME:CONTENT
            var parts = msg.split(":");
            
            if(parts.length >= 3) {
                var senderId = parts[0];
                // var senderName = parts[1]; // Tên người gửi (nếu cần dùng)
                var content = parts.slice(2).join(":"); 

                // Nếu đúng người đang chat thì hiện lên khung chat
                if (senderId == partnerId) {
                    appendMessage(content, 'received');
                } else {
                    // Nếu đang chat với A mà B nhắn tới -> Có thể hiện Toast thông báo ở đây (Tùy chọn)
                    console.log("Tin nhắn từ người khác!");
                }
            }
        };

        // --- 3. GỬI TIN NHẮN ĐI ---
        function sendMessage() {
            var input = document.getElementById("msgInput");
            var content = input.value.trim();
            if (content === "") return;

            // Gửi lên server: ME:PARTNER:CONTENT
            var payload = myId + ":" + partnerId + ":" + content;
            console.log("📤 Đang gửi: " + payload);
            socket.send(payload);
            
            // Hiển thị ngay lên màn hình của mình
            appendMessage(content, 'sent');
            input.value = "";
            input.focus();
        }

        // --- HÀM HỖ TRỢ ---
        function appendMessage(text, type) {
            var chatBox = document.getElementById("chatBox");
            var div = document.createElement("div");
            div.className = "message " + type;
            div.innerText = text; // Dùng innerText cho an toàn
            chatBox.appendChild(div);
            scrollToBottom();
        }

        function handleEnter(e) {
            if (e.key === 'Enter') sendMessage();
        }

        function scrollToBottom() {
            var chatBox = document.getElementById("chatBox");
            chatBox.scrollTop = chatBox.scrollHeight;
        }

        // Tự cuộn xuống cuối khi mới vào
        window.onload = scrollToBottom;
    </script>

</body>
</html>