---
title:  "CSS Learning Notes Chapter I"
date: "2024-06-01"
cover:
  image: https://s2.loli.net/2024/06/01/PUCEYgaOnefo9rt.png 
  caption: "https://nixos.ocfox.me"
tags: ["javascript", "html", "notes"]
---

Try to make a nixos boot animation. (log scroll on screen.)

The repo link: https://github.com/ocfox/booti . This site has none imported js or css library.

First need make a animation let text display line by line.
So I tried to set a delay for every line, when open page hide (don't display) every paragraph in css. 
```css
p {
  display: none; /* Initially hide all paragraphs */
  margin: 1px 0 0 1px;
}
```
Then set a delay increase by degrees for every single line with js. Use `EventListener` get every
paragraph element, and set 500ms * (current lines) delay make it `display` `none` -> `block`.
So them will display right.
```js
document.addEventListener("DOMContentLoaded", function() {
  const paragraphs = document.querySelectorAll('p');
  let delay = 500;

  paragraphs.forEach((p, i) => {
    setTimeout(() => {
      p.style.display = 'block';
    }, i * delay);
  });
});
```
A basic Terminal like page css.
```css
body {
  background: #000; /* Black background */
  padding-top: 10px;
  color: white;
  font-family: "Terminus", monospace;
  font-size: 15px;
}
```
And every 'OK' should be green. so use script replace them class and css to change it color.
```js
paragraphs.forEach(p => {
  p.innerHTML = p.innerHTML.replace(/OK/g, '<span class="green">OK</span>');
});
```
```css
.green {
  color: green;
}
```
Now need a auto scroll, make sure it looks like real boot log.
Just let it scroll to bottom when every line display.
```js
paragraphs.forEach((p, i) => {
  window.scrollTo(0, document.body.scrollHeight); // Scroll to the bottom of the page
  setTimeout(() => {
    p.style.display = 'block';
  }, i * delay);
});
```
Last, replece 500ms to random delay. Now I need a blink cursor '_'.
The blink is not animation, and the visibility switch, so it will like
machanical switch.
```html
<span class="blink">_</span>
```
```css
.blink {
  animation: blink 1s steps(1, end) infinite;
}

@keyframes blink {
  50% {
    visibility: hidden;
  }
}
```
And a input box, I add a empty element as placeholder.
```html
<span id="input-placeholder"></span><span class="blink">_</span>
```

```css
input.dynamic-width {
  background: transparent;
  color: white;
  border: none; /* Set border none to hide that highlit boader */
  font-family: "Terminus", monospace;
  font-size: 15px;
  outline: none;
  caret-color: transparent;
  margin: 0;
  padding: 0;
  position: relative;
  right: -10px; /* hacky way to move text to right, but not good way */
}
```

```js
setTimeout(() => {
  const input = document.createElement('input');
  input.type = 'text';
  input.classList.add('dynamic-width');
  const placeholder = document.querySelector('#input-placeholder');
  placeholder.replaceWith(input);

  // Adjust input width dynamically based on content
  input.addEventListener('input', () => {
    input.style.width = ((input.value.length + 1) * 1) + 'ch';
  });

  input.focus();

  function typeText(element, text, delay) {
    let index = 0;
    function addCharacter() {
      if (index < text.length) {
        element.value += text[index];
        element.style.width = ((element.value.length + 1) * 1) + 'ch';
        index++;
        setTimeout(addCharacter, delay);
      }
    }
    addCharacter();
  }

  input.focus();
  typeText(input, 'hello', 200);

  document.addEventListener('click', () => {
    input.focus();
  });
}, cumulativeDelay + 200);
```
This part a little long, but it simple. Today will poweroff soon. Tomorrow fill it.
