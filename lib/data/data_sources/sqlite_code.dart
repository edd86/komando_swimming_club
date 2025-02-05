String sqlUsers = '''
CREATE TABLE IF NOT EXISTS users (
id INTEGER PRIMARY KEY NOT NULL,
name TEXT NOT NULL,
phone  TEXT NOT NULL UNIQUE,
userName TEXT NOT NULL UNIQUE,
password TEXT NOT NULL UNIQUE);''';

String sqlProfesores = '''
CREATE TABLE IF NOT EXISTS profesores (
id INTEGER PRIMARY KEY NOT NULL,
name TEXT NOT NULL,
age INTEGER NOT NULL,
phone TEXT NOT NULL,
dateOfBirth TEXT NOT NULL,
beginDate TEXT NOT NULL,
obs TEXT);''';

String sqlCaja = '''
CREATE TABLE IF NOT EXISTS caja (
id INTEGER PRIMARY KEY NOT NULL,
monto REAL NOT NULL);''';

String sqlAlumnos = '''
CREATE TABLE IF NOT EXISTS alumnos (
id INTEGER PRIMARY KEY NOT NULL,
name TEXT NOT NULL,
edad INTEGER NOT NULL,
phone TEXT NOT NULL,
dateOfBirth TEXT NOT NULL,
dateOfRegister TEXT NOT NULL,
obs TEXT NOT NULL,
ppff TEXT NOT NULL,
profesorId INTEGER NOT NULL,
FOREIGN KEY(profesorId) REFERENCES profesor(id));''';

String sqlRegistroLogs = '''
CREATE TABLE IF NOT EXISTS registro_logs (
id INTEGER PRIMARY KEY NOT NULL,
login TEXT NOT NULL,
logout TEXT NOT NULL,
isLogged BOOLEAN NOT NULL,
userId INTEGER NOT NULL,
FOREIGN KEY(userId) REFERENCES user(id));''';

String sqlIngresos = '''
CREATE TABLE ingresos (
id INTEGER PRIMARY KEY NOT NULL,
fecha TEXT NOT NULL,
monto REAL NOT NULL,
obs TEXT,
cajaId INTEGER NOT NULL,
FOREIGN KEY(cajaId) REFERENCES caja(id));''';

String sqlEgresos = '''
CREATE TABLE egresos (
id INTEGER PRIMARY KEY NOT NULL,
fecha TEXT NOT NULL,
monto REAL NOT NULL,
obs  TEXT,
cajaId INTEGER NOT NULL,
FOREIGN KEY(cajaId) REFERENCES caja(id));''';

String sqlAsistencias = '''
CREATE TABLE asistencias (
id INTEGER PRIMARY KEY NOT NULL,
fecha TEXT NOT NULL,
obs TEXT,
estado TEXT CHECK (estado IN('presente', 'ausente', 'licencia')),
alumnoId INTEGER,
profesorId INTEGER,
FOREIGN KEY(alumnoId) REFERENCES alumno(id),
FOREIGN KEY(profesorId) REFERENCES profesor(id));''';

String sqlRegistros = '''
CREATE TABLE registros (
id INTEGER PRIMARY KEY NOT NULL,
fecha TEXT NOT NULL,
userId INTEGER NOT NULL,
profesorId INTEGER ,
alumnoId INTEGER,
ingresoId INTEGER,
egresoId INTEGER,
FOREIGN KEY(userId) REFERENCES user(id),
FOREIGN KEY(profesorId) REFERENCES profesor(id),
FOREIGN KEY(alumnoId) REFERENCES alumno(id),
FOREIGN KEY(ingresoId) REFERENCES ingresos(id),
FOREIGN KEY(egresoId) REFERENCES egreso(id));''';
