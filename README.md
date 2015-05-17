Mutterer
========
> Centralise and automate your client-side email configuration.

Mutterer is a tool to let you generate your email configuration for
**mutt**, **offlineimap**, **msmtp** for all your email accounts from a
single muttererrc configuration file.

To make automation possible, it translates the central configuration file to
**bash**, so you can use the full power of bash within your config.

It was created from the observation that a lot of configuration code is
redundant amongst these three programs as well as amongst the various
accounts one may possess (if you're like me and have several accounts).

Here is an example muttererrc file to show how simple it is to get going
with Mutterer:

```bash
[general]
imap.accounts = john,JMan

[groups]
defaults       = john JMan
defaults_extra = %defaults
main_account   = john

[accounts %defaults]
folder=${MDIR:-~/.mail/}

[account john]
name                  = John Doe
address               = johndoe@mycompany.example.com
password              = mypassword
imap_host             = imap.mycompany.example.com
smtp_host             = smtp.mycompany.example.com:465
smtp.tls              = on
smtp.tls_starttls     = on
account_key           = j
mutt.color status     = black white

[account JMan]
name                  = JMan
address               = jman93874915699913@gmail.com
password              = mypassword
account_key           = J
mutt.color status     = black magenta
# The gmail preset will detect good defaults for imap and smtp here

. all
```

And that's all there is to it for msmtp and offlineimap. For mutt, you'll
probably want to define your own global (as opposed to account-specific)
shortcuts in your ~/.mutt/muttrc which will be included from the main
generated config file (~/.muttrc).

What you get from this config file is:

- IMAP and SMTP setup. Notice how there is no need to explicitly define
  anything relating to imap or smtp for gmail since these are automatically
  configured by the 'all' script included in the last line.
- Shortcut to switch to each account's inbox ("gj" for "john" and "gJ" for
  "JMan"). The shortcut prefix key ("g" by default) is modifiable.
- Shortcut to switch to various basic boxes for each user (by default:
  "\_j": junk/spam, "\_t": trash, "\_s": sent, "\_i": inbox, "\_d": drafts).
  to switch
- Shortcut ('S') to sync the currently focused account with offlineimap.
- Different status bar colour depending on the account you are currently in.
- Other small details. See presets/{all,defaults,detect} for more details.

Note also that this program has a fairly modular design and it should
therefore be pretty easy to add support for other clients or tools. For
instance, adding support for an indexer such as NotMuch or other methods of
accessing POP3 or IMAP.

Installation
------------
**WARNING**: running mutterer will overwrite your previous ~/.muttrc,
~/.offlineimaprc, and ~/.msmtprc so make a backup first!

First, get mutt (I recommend mutt-patched if you're on debian), offlineimap
and msmtp.
You'll also need asciidoc to generate the documentation.

Now, just clone the repository, and from inside it, run "make" to generate
the man pages, followed by "(sudo) make install".
Or if you don't want to install it, you can just run the "mutterer" script
directly from the repository's directory.

Create a ~/.muttererrc, using doc/muttererrc.example as inspiration and get
going with "mutterer install" (**see above WARNING first**).

Contributing
------------
You can help by contributing presets for various email providers. See
"presets/detect".

Currently supported email domains are:

- gmx.com
- hotmail.com
- gmail.com
