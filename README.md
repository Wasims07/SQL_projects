# Design Document

By Mohamed Wasim Akram

Video overview:  https://youtu.be/YspYKpMDjys?si=kXhTydmcTuV-oZ4T

## Scope

Songs: Details such as song name, duration, release date, genre, lyrics, and file path.

Artists: Information about artists including their names, genres, biographies, websites, and contact emails.

Albums: Attributes like album name, release date, and their association with artists.

Playlists: Characteristics such as playlist name, description, creation date, and the songs they contain.

Relationships: Connections between songs and albums, songs and artists, and playlists and songs.

## Functional Requirements

A user should be able to:

Create, read, update, and delete including their details such as song, date, artist, and playlist.

## Representation

### Entities

Artists:

`artist_id` (int, primary key): Unique identifier for each artist.

`artist_name` (string): Name of the artist.

`genre` (string): Genre of music the artist performs.

`biography` (text): Biography or information about the artist.

Albums:

`album_id` (int, primary key): Unique identifier for each album.

`album_name` (string): Name of the album.

`release_date` (date): Date when the album was released.

`artist_id` (int, foreign key): Identifier of the artist who released the album

Songs:

`song_id` (int, primary key): Unique identifier for each song.

`song_name` (string): Name of the song.

`album_id` (int, foreign key): Identifier of the album to which the song belongs.

`artist_id` (int, foreign key): Identifier of the artist who performed the song.

`release_date` (date): Date when the song was released.

Playlists:

`playlist_id` (int, primary key): Unique identifier for each playlist.

`playlist_name` (string): Name of the playlist.

`description` (text): Description or notes about the playlist.

`created_date` (date): Date when the playlist was created.

### Relationships

![alt text](diagram.png)

## Optimizations

### Indexes:

`Index on song_name`:
Enhances search performance when querying songs by their names.

`Index on artist_id`:
Created to optimize queries that retrieve songs by artist.

`Composite Index on (artist_id, album_id)`:
Optimizes queries that retrieve songs by artist or album.

`Index on (release_date, artist_id)`:
Created to enhance performance for queries involving songs by release date and artist.

### Views:

`PlaylistDetails`:
Provides detailed information about songs included in each playlist for streamlined data access and user interface presentation.

`SongDetails`:
Offers comprehensive details about each song, including artist and album information, to facilitate efficient data retrieval and application functionalities.

`ArtistAlbumCount`:
Aggregates and displays the number of albums released by each artist, aiding in artist profiling and analytical insights within the music database.

### Triggers:

`after_update_trigger`:
Updates related entities when a song's details are modified

`SongInsertTrigger trigger`:
Updates album metadata automatically when new songs are inserted.

`SongDeleteTrigger trigger`:
Removes song references from playlists when songs are deleted from the database.

## Limitations

The Song table does not store the song's duration, which is an important attribute for music streaming platforms.

The Song table lacks a field to store the song's lyrics, which could be useful for features like lyric search or display.

The Song table does not have a field to store the song's file format or encoding, which is crucial for music playback and streaming.
