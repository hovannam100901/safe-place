window.onload = function() {
    scrollToBottom();
  };
  
  function scrollToBottom() {
    var conversations = document.getElementById('conversations');
    conversations.scrollTop = conversations.scrollHeight;
  }