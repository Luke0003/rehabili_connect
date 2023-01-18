import consumer from "./consumer"

consumer.subscriptions.create("ChatChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
    if (data.user == "client" ) {
      // 利用者がチャットを送ったときの処理
      const clientImage = document.getElementById('client_image');
      const chatPartner = document.getElementById('chat_partner_name');
      const chatPartnerClass = chatPartner.className;
      if (data.user == chatPartnerClass) {
         // セラピスト側のview
        const html = `
          <div class="d-flex justify-content-start">
            <img src="${clientImage["src"]}" class="mb-2 rounded-circle" %>
          </div>
          <div class="d-flex justify-content-start">
            <p class="another_chat ml-5 mb-0">
              ${data.content.message.replace(/\n/g, '<br>')}
            </p>
          </div>
          <div class="d-flex justify-content-start">
            <p class="text-left ml-5">
              <span class="created_at">${data.created_at}</span>
            </p>
          </div>`;

        const messages = document.getElementById('messages_all');
        const newMessage = document.getElementById('chat_message');
        messages.insertAdjacentHTML('beforeend', html);
        newMessage.value = '';
        $('#errors').html("");
        $(".chat_btn").removeAttr("disabled");
      }else{
         // 利用者側のview
        const html = `
          <div class="d-flex justify-content-end">
            <img src="${clientImage["src"]}" class="mb-2 rounded-circle">
          </div>
          <div class="d-flex justify-content-end">
            <p class="text-left my_chat mr-5 mb-0">
              ${data.content.message.replace(/\n/g, '<br>')}
            </p>
          </div>
          <div class="d-flex justify-content-end">
            <p class="text-left mr-5">
              <span class="created_at">${data.created_at}</span>
            </p>
          </div>`;

        const messages = document.getElementById('messages_all');
        const newMessage = document.getElementById('chat_message');
        messages.insertAdjacentHTML('beforeend', html);
        newMessage.value = '';
        $('#errors').html("");
        $(".chat_btn").removeAttr("disabled");
      }
    }else{
      // セラピストがチャットを送ったときの処理
      const therapistImage = document.getElementById('therapist_image');
      const chatPartner = document.getElementById('chat_partner_name');
      const chatPartnerClass = chatPartner.className;
      if (data.user == chatPartnerClass) {
        // 利用者側のview
        const html = `
          <div class="d-flex justify-content-start">
            <img src="${therapistImage["src"]}" class="mb-2 rounded-circle">
          </div>
          <div class="d-flex justify-content-start">
            <p class="another_chat ml-5 mb-0">
               ${data.content.message.replace(/\n/g, '<br>')}
            </p>
          </div>
          <div class="d-flex justify-content-start">
            <p class="text-left ml-5">
              <span class="created_at">${data.created_at}</span>
            </p>
          </div>`;

        const messages = document.getElementById('messages_all');
        const newMessage = document.getElementById('chat_message');
        messages.insertAdjacentHTML('beforeend', html);
        newMessage.value = '';
        errorMessage.value = '';
        $('#errors').html("");
        $(".chat_btn").removeAttr("disabled");
      }else{
         // セラピスト側のview
        const html = `
          <div class="d-flex justify-content-end">
            <img src="${therapistImage["src"]}" class="mb-2 rounded-circle">
          </div>
          <div class="d-flex justify-content-end">
            <p class="text-left my_chat mr-5 mb-0">
              ${data.content.message.replace(/\n/g, '<br>')}
            </p>
          </div>
          <div class="d-flex justify-content-end">
            <p class="text-left mr-5">
              <span class="created_at">${data.created_at}</span>
            </p>
          </div>`;

        const messages = document.getElementById('messages_all');
        const newMessage = document.getElementById('chat_message');
        messages.insertAdjacentHTML('beforeend', html);
        newMessage.value = '';
        $('#errors').html("");
        $(".chat_btn").removeAttr("disabled");
      }
    }
  }
});
