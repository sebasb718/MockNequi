# MockNequi

Instrucciones de instalación

1. Correr el script que se encuentra en la carpeta Database para crear el entorno de base de datos.

2. Las credenciales que el programa va a buscar por defecto son: 
    Usuario:root, Password:root, Host:localhost.

3. Es necesario que el usuario root de MySql no este usando encripción SHA para la contraseña, en caso de que sea asi (MySql 8), correr el siguiente script para permitir que la gema mysql2 pueda autenticar correctamente (la contraseña de root pasará a ser root): "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'root'; FLUSH PRIVILEGES"

4. Para que ruby se conecte a la base de datos es necesario instalar la gema mysql2, para ello  corra el comando "gem install mysql2"

5. Para abrir el programa, ejecutar el archivo Mock_Nequi.rb
