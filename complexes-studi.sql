CREATE DATABASE complexes DEFAULT CHARACTER SET utf8 ;
USE complexes ;

CREATE TABLE gender (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    gender VARCHAR(20) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE age (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    age VARCHAR(20) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE movie (
    id INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(45) NOT NULL,
    summary TEXT NOT NULL,
    poster VARCHAR(45) NOT NULL,
    duration VARCHAR(10) NOT NULL,
    trailer VARCHAR(45) NOT NULL,
    release_date DATE NOT NULL,
    gender_id INT NOT NULL,
    age_id INT NOT NULL,
    PRIMARY KEY (id, gender_id, age_id),
    FOREIGN KEY (gender_id) REFERENCES gender (id) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (age_id) REFERENCES age (id) ON DELETE RESTRICT ON UPDATE CASCADE)
ENGINE = InnoDB;


CREATE TABLE participant (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(20) NOT NULL,
    lastname VARCHAR(20) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE role (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    role VARCHAR(15) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE team (
    participant_id INT NOT NULL,
    movie_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (participant_id, movie_id, role_id),
    FOREIGN KEY (participant_id) REFERENCES participant (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movie (id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (role_id) REFERENCES role (id) ON DELETE CASCADE ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE complexe (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    adress VARCHAR(100) NOT NULL,
    zip INT NOT NULL,
    city VARCHAR(20),
    number_halls INT NOT NULL,
    number_seats INT NOT NULL)
ENGINE = InnoDB;

CREATE TABLE hall (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    name VARCHAR(20) NOT NULL,
    capacity INT NOT NULL,
    handicap_access TINYINT NOT NULL)
ENGINE = InnoDB;

CREATE TABLE version (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    version VARCHAR(10) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE session (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    movie_id INT NOT NULL,
    complexe_id INT NOT NULL,
    hall_id INT NOT NULL,
    date DATE NOT NULL,
    hour VARCHAR(10) NOT NULL,
    version_id INT NOT NULL,
    UNIQUE (movie_id, complexe_id, hall_id, date, hour),
    FOREIGN KEY (movie_id) REFERENCES movie (id) ON DELETE CASCADE ON UPDATE NO ACTION, -- quand je supprime un film je veux qu'il supprime les s??ances concern??es
    FOREIGN KEY (complexe_id) REFERENCES complexe (id) ON DELETE RESTRICT ON UPDATE CASCADE, -- une fois les complexes cr????s en base de donn??e, on n'aura pas besoin de les supprimer mais seulement de les mettre ?? jour si besoin.
    FOREIGN KEY (hall_id) REFERENCES hall (id) ON DELETE RESTRICT ON UPDATE CASCADE, -- une fois les salles cr????es en base de donn??e, on n'aura pas besoin de les supprimer mais seulement de les mettre ?? jour si besoin.
    FOREIGN KEY (version_id) REFERENCES version (id) ON DELETE NO ACTION ON UPDATE NO ACTION) -- une fois les versions de film cr????es en base de donn??e, on n'aura pas besoin de les supprimer mais seulement de les mettre ?? jour si besoin.
ENGINE = InnoDB;

CREATE TABLE user (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    firstname VARCHAR(20) NOT NULL,
    lastname VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    passworld VARCHAR(60) NOT NULL,
    date_creation DATE NULL)
ENGINE = InnoDB;

CREATE TABLE seat (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    number VARCHAR(4) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE price (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    category VARCHAR(30) NOT NULL,
    price DECIMAL(10,2) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE payment (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    payment_method VARCHAR(20) NOT NULL)
ENGINE = InnoDB;

CREATE TABLE booking (
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    session_id INT NOT NULL,
    seat_id INT NOT NULL,
    price_id INT NOT NULL,
    payment_id INT NOT NULL,
    UNIQUE (seat_id, session_id),
    FOREIGN KEY (user_id) REFERENCES user (id) ON DELETE CASCADE ON UPDATE CASCADE,             -- lorsqu'on supprime un user, ses r??servations le sont aussi.
    FOREIGN KEY (seat_id) REFERENCES seat (id) ON DELETE RESTRICT ON UPDATE CASCADE,            -- une fois les si??ges cr????s en base de donn??e, on n'aura pas besoin de les supprimer mais seulement de les mettre ?? jour si besoin.
    FOREIGN KEY (price_id) REFERENCES price (id) ON DELETE RESTRICT ON UPDATE CASCADE,          -- une fois les prix cr????s en base de donn??e, on n'aura pas besoin de les supprimer mais seulement de les mettre ?? jour si besoin.
    FOREIGN KEY (payment_id) REFERENCES payment (id) ON DELETE RESTRICT ON UPDATE CASCADE,      -- une fois les modes de paiement cr????s en base de donn??e, on n'aura pas besoin de les supprimer mais seulement de les mettre ?? jour si besoin.
    FOREIGN KEY (session_id) REFERENCES session (id) ON DELETE CASCADE ON UPDATE CASCADE)       -- lorsqu'on supprime une s??ance, les r??servations le sont aussi.
ENGINE = InnoDB;


INSERT INTO gender (gender) VALUES ('Com??die'), ('Com??die romantique'), ('Com??die dramatique'), ('Action'), ('Aventure'), ('Horreur'), ('Science fiction'), ('Animation');

INSERT INTO age (age) VALUES ('12'), ('16'), ('18'), ('Tout public');

INSERT INTO movie (title, summary, poster, duration, trailer, release_date, gender_id, age_id) VALUES 
('Thor : Love and Thunder', "Le Dieu du Tonnerre entame un voyage ?? nul autre pareil : la qu??te de la paix int??rieure. Mais sa retraite est interrompue par un tueur galactique nomm?? Gorr le Dieu Boucher, qui vise l'extinction des dieux. Pour affronter cette menace, Thor s'assure l'aide du Roi Valkyrie, de Korg et de son ex-petite amie Jane Foster, qui, ?? la surprise de Thor, parvient inexplicablement ?? manier son marteau magique, Mjolnir, sous l'identit?? de Mighty Thor, la D??esse du Tonnerre. Ensemble, ils s'embarquent dans une haletante aventure cosmique pour percer le myst??re de le vengeance du Dieu Boucher et l'arr??ter avant qu'il soit trop tard.", '', '1h59', '', '2022-07-15', '4', '4'),
('La petite bande', "La petite bande, c'est Cat, Fouad, Antoine et Sami, quatre coll??giens de 12 ans. Par fiert?? et provocation, ils s'embarquent dans un projet fou : faire sauter l'usine qui pollue leur rivi??re depuis des ann??es. Mais dans le groupe fra??chement form?? les d??saccords sont fr??quents et les votes ?? ??galit?? paralysent constamment l'action. Pour se d??partager, ils d??cident alors de faire rentrer dans leur petite bande, Aim??, un gamin rejet?? et solitaire. Aussi excit??s qu'affol??s par l'ampleur de leur mission, les cinq complices vont apprendre ?? vivre et ?? se battre ensemble dans cette aventure dr??le et incertaine qui va totalement les d??passer.", '', '1H40', '', '2022-07-13', '1', '4'),
('Ducobu Pr??sident!', "Une nouvelle ann??e scolaire d??marre pour Ducobu ! A l'??cole Saint Potache, une ??lection exceptionnelle va avoir lieu pour ??lire le pr??sident des ??l??ves. C'est le d??but d'une campagne ??lectorale un peu folle dans laquelle vont se lancer les deux adversaires principaux : Ducobu et L??onie. A l'aide de son ami Kitrish et de ses nombreux gadgets, Ducobu triche comme jamais et remporte l'??lection. Parc d'attraction dans la cour, retour de la sieste, suppression des l??gumes ?? la cantine, pour Latouche, trop c'est trop !", '', '1h26', '', '2022-07-06', '1', '4'), ('Les Minions 2 : Il ??tait une fois Gru', "Alors que les ann??es 70 battent leur plein, Gru qui grandit en banlieue au milieu des jeans ?? pattes d'??l??phants et des chevelures en fleur, met sur pied un plan machiav??lique ?? souhait pour r??ussir ?? int??grer un groupe c??l??bre de super m??chants, connu sous le nom de Vicious 6, dont il est le plus grand fan. Il est second?? dans sa t??che par les Minions, ses petits compagnons aussi turbulents que fid??les. Avec l'aide de Kevin, Stuart, Bob et Otto ??? un nouveau Minion ...", '', '1h27', '', '2022-07-06', '8', '4');

INSERT INTO participant (firstname, lastname) VALUES ('Chris', 'Hemsworth'), ('Natalie', 'Portman'), ('Paul', 'Belhoste'), ('Colombe', 'Schmidt'), ('Elie', 'Semoun'), ('G??rard', 'Jugnot'), ('Taika', 'Waititi'), ('Pierre', 'Salvadori'), ('Elie', 'Semoun'), ('Kyle', 'Balda'), ('Brad', 'Ableson');

INSERT INTO role (role) VALUES ('acteur'), ('r??alisateur');

INSERT INTO team (movie_id, participant_id, role_id) VALUES ('1', '1', '1'), ('1', '2', '1'), ('2', '3', '1'), ('2', '4', '1'), ('3', '5', '1'), ('3', '6', '1'), ('1', '7', '2'), ('2', '8', '2'), ('3', '9', '2'), ('4', '10', '2'), ('4', '11', '2');

INSERT INTO complexe (name, adress, zip, city, number_halls, number_seats) VALUES ('complexe Annecy', '1 rue du promontoire', '74100', 'ANNECY', '12', '1548'), ('complexe Thonon', '18 rue du lavoir' , '74200', 'THONON', '10', '1256'), ('complexe Archamps', '45 rue du stade', '74160', 'ARCHAMPS', '12', '1824');

INSERT INTO hall (name, capacity, handicap_access) VALUES ('salle 1 - Annecy', '472', '1'), ('salle 2 - Annecy', '236', '1'), ('salle 3 - Annecy', '224', '1'), ('salle 4 - Annecy', '86', '1'), ('salle 5 - Annecy', '78', '1'), ('salle 6 - Annecy', '66', '1'), ('salle 7 - Annecy', '212', '1'), ('salle 8 - Annecy', '236', '1'), ('salle 9 - Annecy', '236', '1'), ('salle 10 - Annecy', '412', '1'), ('salle 11 - Annecy', '126', '1'), ('salle 12 - Annecy', '126', '1'), ('salle 1 - Archamps', '472', '1'),  ('salle 2 - Archamps', '236', '1'), ('salle 3 - Archamps', '224', '1'), ('salle 4 - Archamps', '86', '1'), ('salle 5 - Archamps', '78', '1'), ('salle 6 - Archamps', '66', '1'), ('salle 7 - Archamps', '212', '1'), ('salle 8 - Archamps', '236', '1'), ('salle 9 - Archamps', '236', '1'), ('salle 10 - Archamps', '412', '1'), ('salle 1 - Thonon', '472', '1'),  ('salle 2 - Thonon', '236', '1'), ('salle 3 - Thonon', '224', '1'), ('salle 4 - Thonon', '86', '1'), ('salle 5 - Thonon', '78', '1'), ('salle 6 - Thonon', '66', '1'), ('salle 7 - Thonon', '212', '1'), ('salle 8 - Thonon', '236', '1'), ('salle 9 - Thonon', '236', '1'), ('salle 10 - Thonon', '412', '1'), ('salle 11 - Thonon', '126', '1'), ('salle 12 - Thonon', '126', '1');

INSERT INTO version (version) VALUES ('VO'), ('VOST'), ('VF');

INSERT INTO session (movie_id, complexe_id, hall_id, date, hour, version_id) VALUES ('1', '1', '1', '2022-07-29', '14h00', '3'), ('1', '1', '1', '2022-07-29', '16h30', '3'), ('1', '1', '1', '2022-07-29', '19h00', '3'), ('1', '2', '1', '2022-07-29', '14h00', '3'),  ('1', '2', '1', '2022-07-29', '16h30', '3'),  ('1', '2', '1', '2022-07-29', '19h00', '3'), ('1', '3', '1', '2022-07-29', '14h00', '3'),  ('1', '3', '1', '2022-07-29', '16h30', '3'),  ('1', '3', '1', '2022-07-29', '19h00', '3'), ('2', '1', '1', '2022-07-29', '14h00', '3'),  ('2', '1', '1', '2022-07-29', '16h30', '3'),  ('2', '1', '1', '2022-07-29', '19h00', '3'), ('2', '2', '1', '2022-07-29', '14h00', '3'),  ('2', '2', '1', '2022-07-29', '16h30', '3'),  ('2', '2', '1', '2022-07-29', '19h00', '3'), ('2', '3', '1', '2022-07-29', '14h00', '3'),  ('2', '3', '1', '2022-07-29', '16h30', '3'),  ('2', '3', '1', '2022-07-29', '19h00', '3'), ('3', '1', '1', '2022-07-29', '14h00', '3'),  ('3', '1', '1', '2022-07-29', '16h30', '3'),  ('3', '1', '1', '2022-07-29', '19h00', '3'), ('3', '2', '1', '2022-07-29', '14h00', '3'),  ('3', '2', '1', '2022-07-29', '16h30', '3'),  ('3', '2', '1', '2022-07-29', '19h00', '3'), ('3', '3', '1', '2022-07-29', '14h00', '3'),  ('3', '3', '1', '2022-07-29', '16h30', '3'),  ('3', '3', '1', '2022-07-29', '19h00', '3'), ('4', '1', '1', '2022-07-29', '14h00', '3'),  ('4', '1', '1', '2022-07-29', '16h30', '3'),  ('4', '1', '1', '2022-07-29', '19h00', '3'), ('4', '2', '1', '2022-07-29', '14h00', '3'),  ('4', '2', '1', '2022-07-29', '16h30', '3'),  ('4', '2', '1', '2022-07-29', '19h00', '3'), ('4', '3', '1', '2022-07-29', '14h00', '3'),  ('4', '3', '1', '2022-07-29', '16h30', '3'),  ('4', '3', '1', '2022-07-29', '19h00', '3');

INSERT INTO user (firstname, lastname, email, passworld, date_creation) VALUES 
('Jos??phine', 'Campo', 'lcampo0@linkedin.com', '$2y$10$8.x4vglRMzM1awW34gIwJODplqdq36M.SEb0uPJKnA4MKE3E0alqq', '2021-10-20'),
('B??rang??re', 'Bassingden', 'ibassingden1@so-net.ne.jp', '$2y$10$ppQRfUcAGabgHIIDSTS11OFXbf22VgRgMKplrC1bkn4EuA9GWZdye', '2022-04-28'),
('U??', 'Paeckmeyer', 'hpaeckmeyer2@mozilla.org', '$2y$10$iAzaYTYv4H5XxNa3yU8wi.Oxf/AXoVy1RB8TpBlMF/Sy6ZF3XWbcW', '2021-09-20'),
('Y??o', 'Beacham', 'hbeacham3@ycombinator.com', '$2y$10$lAa1l9rNgGkju5YIZNrPouAJB0Er2Vdh/QHhhZE/1lyGdCbvpuuoO', '2022-05-06'),
('D??', 'Winscum', 'wwinscum4@posterous.com', '$2y$10$3AFwOnnAvO7ntivscihHXObpsr5Dyfte1UugksNk9TucJPvh078Wq', '2022-07-09'),
('P??n??lope', 'Matushevich', 'cmatushevich5@jugem.jp', '$2y$10$HR/UWzh2GvxFkw6Wz.T7tOvLAiMwF2y8d24mYduVm/vbaUlc.AFlW', '2022-03-05'),
('Alm??rinda', 'Shelsher', 'ashelsher6@elpais.com', '$2y$10$AsZiMtaQtqiB6Ys9A7Kiau1GPgIHiedfR0HsDJMRTYyDA1L/Mo.vm', '2021-09-24'),
('K??', 'Wallenger', 'twallenger7@wordpress.org', '$2y$10$nxcydr2/Aj6jWLofO5ircOStvVPDtrQtvBtL.S0tFxP52v6yUA7y2', '2022-02-26'),
('H??kan', 'Mawd', 'dmawd8@europa.eu', '$2y$10$sOXScFO4QR30OpxZq5g9bO0Pc/ytiI0ccCK63lwuv2ERFxcJ1d1mC', '2021-10-27'),
('Cl??mentine', 'Raper', 'araper9@home.pl', '$2y$10$XQfB1D36GKa8NpyQN6A..egblp0cKpgC6ejhprLoE3hqiSHGmWAPy', '2022-04-09');

INSERT INTO seat (number) VALUES ('A1'), ('A2'),('A3'),('A4'),('A5'),('A6'),('A7'),('A8'),('A9'),('A10'),('A11'),('A12'),('A13'),('A14'),('A15'),('A16'),('B1'), ('B2'),('B3'),('B4'),('B5'),('B6'),('B7'),('B8'),('B9'),('B10'),('B11'),('B12'),('B13'),('B14'),('B15'),('B16'),('C1'), ('C2'),('C3'),('C4'),('C5'),('C6'),('C7'),('C8'),('C9'),('C10'),('C11'),('C12'),('C13'),('C14'),('C15'),('C16');

INSERT INTO price (category, price) VALUES ('Plein tarif', '9.20'), ('Etudiant', '7.60'), ('Moins de 14 ans', '5.90');

INSERT INTO payment (payment_method) VALUES ('Sur place'), ('En ligne');

INSERT INTO booking (user_id, session_id, seat_id, price_id, payment_id) VALUES ('1', '1', '1', '1', '1'),  ('1', '1', '2', '2', '2'), ('2', '2', '2', '3', '1'), ('2', '2', '3', '1', '2'), ('3', '3', '2', '2', '2'), ('4', '3', '3', '3', '1'), ('5', '3', '4', '1', '2'), ('6', '3', '5', '2', '1'), ('7', '1', '23', '3', '2'), ('8', '1', '34', '2', '1'), ('9', '1', '25', '2', '1'), ('1', '10', '1', '1', '1'),  ('1', '11', '2', '2', '2'), ('1', '20', '1', '1', '1'),  ('1', '21', '2', '2', '2');

CREATE USER 'administrator'@'localhost' IDENTIFIED BY '$2y$10$msu6UfG8.kpgu1r0HCWEfezHp1.o8AhewYxzJZvSAADTyMVx6aRxu';
GRANT ALL PRIVILEGES ON complexes.* TO 'administrator'@'localhost';
FLUSH PRIVILEGES;
CREATE USER 'user'@'localhost' IDENTIFIED BY '$2y$10$Gb01JFRa5Qvr5cQe7i8ry.SHOgMuk1QxueG9YXaSo32rlvPUfYF2u';
GRANT SELECT ON complexes.* TO 'user'@'localhost';
FLUSH PRIVILEGES;
