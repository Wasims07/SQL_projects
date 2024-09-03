--insert values to artists
INSERT INTO Artists (artist_id, artist_name, genre, biography)
VALUES
(1, 'Taylor Swift', 'Pop', 'Taylor Alison Swift is an American singer-songwriter.'),
(2, 'Drake', 'Hip Hop', 'Aubrey Drake Graham is a Canadian rapper and singer-songwriter.'),
(3, 'Billie Eilish', 'Alternative', 'Billie Eilish Pirate Baird O''Connell is an American singer-songwriter.');

--insert values to albums
INSERT INTO Albums (album_id, album_name, release_date, artist_id)
VALUES
(1, 'Fearless', '2021-04-09', 1),
(2, 'Certified Lover Boy', '2021-09-03', 2),
(3, 'Happier Than Ever', '2021-07-30', 3);

--insert values to songs
INSERT INTO Songs (song_id, song_name, album_id, artist_id, release_date)
VALUES
(1, 'Love Story', 1, 1, '2021-02-12'),
(2, 'In Too Deep', 2, 2, '2021-09-03'),
(3, 'Happier Than Ever', 3, 3, '2021-07-30');

--insert values to playlists
INSERT INTO Playlists (playlist_id, playlist_name, description, created_date)
VALUES
(1, 'Favorites', 'My favorite songs', '2024-07-28'),
(2, 'Hip Hop Vibes', 'Best hip hop tracks of the year', '2024-07-28');

--insert values to playlist_songs
INSERT INTO Playlist_Songs (playlist_id, song_id, song_order)
VALUES
(1, 1, 1),
(1, 3, 2),
(2, 2, 1);

--select all albums with their respective artists
SELECT Albums.album_name, Artists.artist_name
FROM Albums
INNER JOIN Artists ON Albums.artist_id = Artists.artist_id;

--select all songs from a specific album
SELECT Songs.song_name, Artists.artist_name
FROM Songs
INNER JOIN Albums ON Songs.album_id = Albums.album_id
INNER JOIN Artists ON Songs.artist_id = Artists.artist_id
WHERE Albums.album_name = 'Fearless';

--select songs in a playlist with their order
SELECT Playlists.playlist_name, Songs.song_name, Playlist_Songs.song_order
FROM Playlist_Songs
INNER JOIN Playlists ON Playlist_Songs.playlist_id = Playlists.playlist_id
INNER JOIN Songs ON Playlist_Songs.song_id = Songs.song_id
WHERE Playlists.playlist_name = 'Favorites'
ORDER BY Playlist_Songs.song_order;

--select artists and their total number of albums
SELECT Artists.artist_name, COUNT(Albums.album_id) AS num_albums
FROM Artists
LEFT JOIN Albums ON Artists.artist_id = Albums.artist_id
GROUP BY Artists.artist_name;

--select artists with the most albums
SELECT artist_name, num_albums
FROM (
    SELECT artist_id, COUNT(*) AS num_albums
    FROM Albums
    GROUP BY artist_id
) AS artist_album_counts
JOIN Artists ON Artists.artist_id = artist_album_counts.artist_id
ORDER BY num_albums DESC;

--show playlists with more than 5 songs
SELECT playlist_name
FROM Playlists
WHERE playlist_id IN (
    SELECT playlist_id
    FROM Playlist_Songs
    GROUP BY playlist_id
    HAVING COUNT(*) > 5
);

--Update

--Change song with song_id = 234 to new artist_id
UPDATE Songs
SET artist_id = 5
WHERE song_id = 2;

--Update the release date song_id = 678 to a new date
UPDATE Songs
SET release_date = '2023-01-01'
WHERE song_id = 7;

--Delete

--Delete a song with song_id
DELETE FROM Songs
WHERE song_id = 1;

--Delete a particular album with album_id
DELETE FROM Songs
WHERE album_id = 1;
