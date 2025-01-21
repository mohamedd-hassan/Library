Challenge 102
(Enhanced version of https://challenges.re/44/)

There is an utility which encrypts/decrypts files using a password.
There is an encrypted text file, the password is unknown.
The encrypted file is a text in the English language.

The utility uses a relatively strong cryptosystem, nevertheless, it was implemented with a serious blunder.
With the mistake present, it is possible to decrypt the file with a little effort.

1) Try to find the mistake and decrypt the file.

2) Try to encrypt a file that is not aligned by 4-byte boundary. Say, it may have size of 6 bytes, or 5 ("hello" string).
The resulting (encrypted) file would have a size of 8 bytes. Why?

3) Create a file with random text in your native language. Decrypt it using this utility.
You'll get a file with garbled unreadable contents.
Then encrypt it.
The resulting file will have your random text, as it was at the beginning.
Can you describe, why?
You see, encryption/decryption operations are reversed. So why it works? Is it a bug?

