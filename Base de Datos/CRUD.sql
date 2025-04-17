select * from usuario;

insert into usuario (nombre, apellido, correo, password, rol)
values('Pedro','Gonzalez', 'test@email.com', '098f6bcd4621d373cade4e832627b4f6', 'cliente')

update usuario
set correo = 'pedro@email.com'
where id = '1';

delete from usuario 
where id = '1';