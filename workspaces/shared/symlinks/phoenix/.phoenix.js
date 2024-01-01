Key.on('`', [], () => {
  const isOpen = App.focused().name() === "WezTerm";
  if (!isOpen) {
    App.launch('WezTerm').focus();
  } else {
    App.focused().hide();
  }
});
