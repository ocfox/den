---
title: "Email Structure -- Building an Email Sender with SMTP"
date: "2024-07-26"
tags: ["email", "network", "SMTP", "MIME"]
description: "A guide to creating a tool for sending emails"
---

Using an SMTP library, you can build an app to send emails. However,
it typically doesn't support a function to simply pass the subject,
content, and attachment as parameters.

### Format of Internet Message Bodies

According to [RFC2045](https://datatracker.ietf.org/doc/html/rfc2045),
the MIME (Multipurpose Internet Mail Extensions) format is used.

```plaintext
From: ocfox <i@ocfox.me>
To: Test <test@cyans.dev>
Subject: Test Email
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary=_kuroneko_
```

This is a simple email header where I use a custom boundary `_kuroneko_`.
The boundary is used to separate different parts of the email.

```plaintext
Header ...
--_kuroneko_
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello, this is the text part.
--_kuroneko_
```

### Attachment

An attachment is a part of the email and can be a file,
an image, or anything else you want to send.

If you want to send an EPUB file, you need to add a part to the email like this:

```plaintext
Header ...
--_kuroneko_
Content-Type: application/epub+zip; name="example.epub"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="example.epub"

UEsDBAoAAA...
--_kuroneko_--
```

Use any Base64 encoding library to encode the file,
combining the pieces together. Then, send them using SMTP.

It's quite simple, right?
