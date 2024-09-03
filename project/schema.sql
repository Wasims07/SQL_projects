--create artists table
CREATE TABLE Artists (
    artist_id INT PRIMARY KEY,
    artist_name VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    biography TEXT
);

--create albums table
CREATE TABLE Albums (
    album_id INT PRIMARY KEY,
    album_name VARCHAR(200) NOT NULL,
    release_date DATE,
    artist_id INT,
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

--create songs table
CREATE TABLE Songs (
    song_id INT PRIMARY KEY,
    song_name VARCHAR(200) NOT NULL,
    album_id INT,
    artist_id INT,
    release_date DATE,
    FOREIGN KEY (album_id) REFERENCES Albums(album_id),
    FOREIGN KEY (artist_id) REFERENCES Artists(artist_id)
);

--create playlists table
CREATE TABLE Playlists (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR(200) NOT NULL,
    description TEXT,
    created_date DATE
);

--create playlist_songs table
CREATE TABLE Playlist_Songs (
    playlist_id INT,
    song_id INT,
    song_order INT,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlists(playlist_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);

--view
--show the song details
CREATE VIEW SongDetails AS
SELECT Songs.song_id, Songs.song_name, Artists.artist_name, Albums.album_name
FROM Songs
INNER JOIN Albums ON Songs.album_id = Albums.album_id
INNER JOIN Artists ON Songs.artist_id = Artists.artist_id;

--show the playlist details
CREATE VIEW PlaylistDetails AS
SELECT Playlists.playlist_id, Playlists.playlist_name, Songs.song_name
FROM Playlists
INNER JOIN Playlist_Songs ON Playlists.playlist_id = Playlist_Songs.playlist_id
INNER JOIN Songs ON Playlist_Songs.song_id = Songs.song_id;

--show all albums counts
CREATE VIEW ArtistAlbumCount AS
SELECT Artists.artist_id, Artists.artist_name, COUNT(Albums.album_id) AS num_albums
FROM Artists
LEFT JOIN Albums ON Artists.artist_id = Albums.artist_id
GROUP BY Artists.artist_id, Artists.artist_name;

--index
--for songname
CREATE INDEX idx_song_name ON Songs(song_name);

--for artist_id
CREATE INDEX idx_artist_id ON Songs(artist_id);

--for artist_id and album_id
CREATE INDEX idx_artist_album ON Songs(artist_id, album_id);

--for release_date, artist_id
CREATE INDEX idx_release_date_artist_id ON Songs(release_date, artist_id);

--Triggers
--for after_update_trigger
CREATE TRIGGER after_update_trigger
AFTER UPDATE ON Albums
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Logs (action, table_name, record_id, timestamp)
    VALUES ('UPDATE', 'Albums', NEW.album_id, NOW());
END;

--for SongInsertTrigger
CREATE TRIGGER SongInsertTrigger
AFTER INSERT ON Songs
FOR EACH ROW
BEGIN
    UPDATE Albums
    SET release_date = NEW.release_date
    WHERE album_id = NEW.album_id;
END;

--for SongDeleteTrigger
CREATE TRIGGER SongDeleteTrigger
AFTER DELETE ON Songs
FOR EACH ROW
BEGIN
    DELETE FROM Playlist_Songs
    WHERE song_id = OLD.song_id;
END;
