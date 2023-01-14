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
    if (data.user == 1 ) {
      const clientImage = document.getElementById('client_image');
      console.log(clientImage["src"])
      const html = `
      <div class="d-flex justify-content-end">
        <img src="${clientImage["src"]}" class="mb-2 rounded-circle">
      </div>
      <div class="d-flex justify-content-end">
        <p class="text-left my_chat mr-5 mb-0">
          ${data.content.message}
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
      $(".chat_btn").removeAttr("disabled");
    }else{
      const therapistImage = document.getElementById('therapist_image');
      const html = `
      <div class="d-flex justify-content-end">
        <img src="${therapistImage["src"]}" class="mb-2 rounded-circle">
      </div>
      <div class="d-flex justify-content-end">
        <p class="text-left my_chat mr-5 mb-0">
          ${data.content.message}
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
      $(".chat_btn").removeAttr("disabled");
    }
  }
});
