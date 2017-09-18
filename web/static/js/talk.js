let Talk = {
    // 初期化処理.ソケットに接続します
    init: function(socket, element) {
        if (!element) { return;}
        socket.connect();
        this.onReady(socket);
    },
 
    // イベントリスナーの登録.
    // channel.pushで入力されたメッセージをソケットを通してサーバへ送信します
    // channel.onでサーバから送信されたメッセージをソケットを通して受け取り画面に表示します
    onReady: function(socket) {
        let channel = socket.channel("talks:hello", {});
        let chatInput = $("#msg-input");
        let msgContainer = $("#msg-container");
 
        channel.join()
            .receive("ok", resp => { console.log("Welcom to Phoenix Chat!", resp); })
            .receive("error", resp => {console.log("Unable to join", resp); });
 
        chatInput.on("keypress", event => {
            if (event.keyCode === 13) {
                channel.push("msg", { body: chatInput.val() });
                chatInput.val("");
            }
        });
 
        channel.on("msg", payload => {
            msgContainer.append(this.messageTemplate(payload));
            scrollTo(0, document.body.scrollHeight);
        });
    },
 
    sanitize: function(html) { return $("<div/>").text(html).html(); },
 
    messageTemplate: function(msg) {
        let username = this.sanitize(msg.user)
        let body = this.sanitize(msg.body);
        return(`<p><a href='#'>[${username}]</a>&nbsp; ${body}</p>`)
 
    }
}
 
export default Talk