# openSESAME-Password-Manager  
## _open source password manager with AES256 encryption_  

openSESAME is a cross-platform password manager developed in C++ with GUI created in QML.  
I created it as an final project for my C++ classes at the University of Wroclaw.  

## Features  

- Store your login credentionals (e.g. social media passwords, banking data)  
- Generate strong, unique and random password (you specify the length and alphanumeric criteria)  
- Encrypt all your data using AES256-ECB cipher  
- Create many vaults to meet your needs  
- ✨ More to come ✨  


## Screenshots  
![login](https://raw.githubusercontent.com/tTargiel/openSESAME-Password-Manager/main/images/screenshots/login.png?raw=true)  
![register](https://raw.githubusercontent.com/tTargiel/openSESAME-Password-Manager/main/images/screenshots/register.png?raw=true)  
![main](https://raw.githubusercontent.com/tTargiel/openSESAME-Password-Manager/main/images/screenshots/main.png?raw=true)  
![vault](https://raw.githubusercontent.com/tTargiel/openSESAME-Password-Manager/main/images/screenshots/vault.png?raw=true)  
![generate](https://raw.githubusercontent.com/tTargiel/openSESAME-Password-Manager/main/images/screenshots/generate.png?raw=true)  


## Tech  

openSESAME uses those technologies to work properly:  

- [C++] - handle application logic (back-end)  
- [Qt] - IDE for cross-platform applications  
- [QML] - GUI language enhanced for desktop apps!  
- [AES256] - Rijndael block cipher with 256-bit keylength  
- [JSON] - data interchange format to store and transmit data objects  

And of course openSESAME itself is open source with a [public repository][openSESAME] on GitHub.  

## Installation  

openSESAME requires [Qt] to run.  

Clone the [repository][git-repo-url] and open project (./openSESAME.pro) in Qt Creator to build.  

```sh  
git clone https://github.com/tTargiel/openSESAME-Password-Manager.git  
cd openSESAME-Password-Manager/  
qtcreator ./openSESAME.pro  
```  

## Dependencies  

openSESAME is currently extended with the following dependencies.  

| Name | Link |  
| ------ | ------ |  
| Qt-AES | [public repository][QtAES] |  

## License  

GPL-3.0  

**openSESAME is combination of "open source" and "sesame"**  
**from the classic story Ali Baba and the Forty Thieves.**  

**Free Software, Hell Yeah!**  

[//]: # (These are reference links used in the body of this note and get stripped out when the markdown processor does its job. There is no need to format nicely because it shouldn't be seen. Thanks SO - http://stackoverflow.com/questions/4823468/store-comments-in-markdown-syntax)  

[openSESAME]: <https://github.com/tTargiel/openSESAME-Password-Manager>  
[git-repo-url]: <ttps://github.com/tTargiel/openSESAME-Password-Manager.git>  
[C++]: <https://isocpp.org/>  
[Qt]: <https://www.qt.io/>  
[QML]: <https://doc.qt.io/qt-5/qml-tutorial.html>  
[AES256]: <https://en.wikipedia.org/wiki/Advanced_Encryption_Standard>  
[JSON]: <https://en.wikipedia.org/wiki/JSON>  

[QtAES]: <https://github.com/bricke/Qt-AES>  
