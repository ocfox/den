{
  normal = {
    "esc" = "collapse_selection";
    "J" = [
      "move_line_down"
      "move_line_down"
      "move_line_down"
      "move_line_down"
      "move_line_down"
    ];
    "K" = [
      "move_line_up"
      "move_line_up"
      "move_line_up"
      "move_line_up"
      "move_line_up"
    ];
    "H" = "goto_line_start";
    "L" = "goto_line_end";
    "C-y" = "yank_joined_to_clipboard";
    "C-p" = "paste_clipboard_after";
    space = {
      w = ":w";
      q = ":q";
    };
  };
  insert = {
    "C-y" = "yank_joined_to_clipboard";
    "C-p" = "paste_clipboard_after";
  };
  select = {
    "H" = "goto_line_start";
    "L" = "goto_line_end";
  };
}
