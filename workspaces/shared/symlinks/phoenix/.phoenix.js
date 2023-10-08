Key.on('`', [], () => {
  const isOpen = App.focused().name() === "kitty";
  if (!isOpen) {
    App.launch('Kitty').focus();
  } else {
    App.focused().hide();
  }
});
