create database Crud_ASPNET_Web
use Crud_ASPNET_Web

create table Usuarios(
Id int identity(1,1),
Nombres varchar(50),
Apellidos varchar(50),
Fecha date,
Usuario varchar(50),
Clave varbinary(max)
)

create table Imagenes(
IdUsuario int,
Imagen image
)

create procedure Registrar
@Nombres varchar(50),
@Apellidos varchar(50),
@Fecha date,
@Usuario varchar(50),
@Clave varchar(100),
@Patron varchar(50),
@IdUsuario int,
@Imagen image
as
begin
insert into Usuarios VALUES(@Nombres, @Apellidos, @Fecha, @Usuario, ENCRYPTBYPASSPHRASE(@Patron, @Clave));
SET @IdUsuario = (SELECT Id FROM Usuarios WHERE Usuario=@Usuario);
INSERT INTO Imagenes VALUES(@IdUsuario, @Imagen)
end

create procedure Validar
@Usuario varchar (50),
@Clave varchar (100),
@Patron varchar (50)
as
begin
SELECT * FROM Usuarios WHERE Usuario=@Usuario AND CONVERT(varchar(100), DECRYPTBYPASSPHRASE(@Patron, Clave))=@Clave
end

create procedure Perfil
@Id int
as
begin
SELECT * FROM Usuarios WHERE Id=@Id;
SELECT * FROM Imagenes WHERE IdUsuario=@Id
end

create procedure Eliminar
@Id int
as
begin
DELETE FROM Usuarios WHERE Id=@Id;
DELETE FROM Imagenes WHERE IdUsuario=@Id
end

create procedure CargarImagen
@Id int
as
begin
SELECT Imagen FROM Imagenes WHERE IdUsuario=@Id
end

create procedure CambiarContrasenia
@Id int,
@Clave varchar(100),
@Patron varchar(50)
as
begin
UPDATE Usuarios SET Clave=(ENCRYPTBYPASSPHRASE(@Patron, @Clave)) WHERE Id=@Id
end

create procedure CambiarImagen
@Id int,
@Imagen image
as
begin
UPDATE Imagenes SET Imagen=@Imagen WHERE IdUsuario=@Id
end

create procedure ContarUsuario
@usuario varchar(50)
as
begin
SELECT COUNT(*) FROM Usuarios WHERE Usuario=@usuario
end

SELECT * FROM Usuarios
SELECT * FROM Imagenes

