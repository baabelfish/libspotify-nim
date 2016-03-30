const
  sf_dynlib = "/lib/libspotify.so"

type 
  sp_uint64* = uint64
  bool* = cuchar
  byte* = cuchar
  sp_session* = object 
  sp_track* = object 
  sp_album* = object 
  sp_artist* = object 
  sp_artistbrowse* = object 
  sp_albumbrowse* = object 
  sp_toplistbrowse* = object 
  sp_search* = object 
  sp_link* = object 
  sp_image* = object 
  sp_user* = object 
  sp_playlist* = object 
  sp_playlistcontainer* = object 
  sp_inbox* = object 

type
  sp_error* = enum 
    SP_ERROR_OK = 0, SP_ERROR_BAD_API_VERSION = 1, 
    SP_ERROR_API_INITIALIZATION_FAILED = 2, SP_ERROR_TRACK_NOT_PLAYABLE = 3, 
    SP_ERROR_BAD_APPLICATION_KEY = 5, SP_ERROR_BAD_USERNAME_OR_PASSWORD = 6, 
    SP_ERROR_USER_BANNED = 7, SP_ERROR_UNABLE_TO_CONTACT_SERVER = 8, 
    SP_ERROR_CLIENT_TOO_OLD = 9, SP_ERROR_OTHER_PERMANENT = 10, 
    SP_ERROR_BAD_USER_AGENT = 11, SP_ERROR_MISSING_CALLBACK = 12, 
    SP_ERROR_INVALID_INDATA = 13, SP_ERROR_INDEX_OUT_OF_RANGE = 14, 
    SP_ERROR_USER_NEEDS_PREMIUM = 15, SP_ERROR_OTHER_TRANSIENT = 16, 
    SP_ERROR_IS_LOADING = 17, SP_ERROR_NO_STREAM_AVAILABLE = 18, 
    SP_ERROR_PERMISSION_DENIED = 19, SP_ERROR_INBOX_IS_FULL = 20, 
    SP_ERROR_NO_CACHE = 21, SP_ERROR_NO_SUCH_USER = 22, 
    SP_ERROR_NO_CREDENTIALS = 23, SP_ERROR_NETWORK_DISABLED = 24, 
    SP_ERROR_INVALID_DEVICE_ID = 25, SP_ERROR_CANT_OPEN_TRACE_FILE = 26, 
    SP_ERROR_APPLICATION_BANNED = 27, SP_ERROR_OFFLINE_TOO_MANY_TRACKS = 31, 
    SP_ERROR_OFFLINE_DISK_CACHE = 32, SP_ERROR_OFFLINE_EXPIRED = 33, 
    SP_ERROR_OFFLINE_NOT_ALLOWED = 34, SP_ERROR_OFFLINE_LICENSE_LOST = 35, 
    SP_ERROR_OFFLINE_LICENSE_ERROR = 36, SP_ERROR_LASTFM_AUTH_ERROR = 39, 
    SP_ERROR_INVALID_ARGUMENT = 40, SP_ERROR_SYSTEM_FAILURE = 41


proc sp_error_message*(error: sp_error): cstring {. cdecl, importc: "sp_error_message", dynlib: sf_dynlib .}

const 
  SPOTIFY_API_VERSION* = 12

type 
  sp_connectionstate* = enum 
    SP_CONNECTION_STATE_LOGGED_OUT = 0, SP_CONNECTION_STATE_LOGGED_IN = 1, 
    SP_CONNECTION_STATE_DISCONNECTED = 2, SP_CONNECTION_STATE_UNDEFINED = 3, 
    SP_CONNECTION_STATE_OFFLINE = 4
  sp_sampletype* = enum 
    SP_SAMPLETYPE_INT16_NATIVE_ENDIAN = 0
  sp_audioformat* = object 
    sample_type*: sp_sampletype
    sample_rate*: cint
    channels*: cint

  sp_bitrate* = enum 
    SP_BITRATE_160k = 0, SP_BITRATE_320k = 1, SP_BITRATE_96k = 2
  sp_playlist_type* = enum 
    SP_PLAYLIST_TYPE_PLAYLIST = 0, SP_PLAYLIST_TYPE_START_FOLDER = 1, 
    SP_PLAYLIST_TYPE_END_FOLDER = 2, SP_PLAYLIST_TYPE_PLACEHOLDER = 3
  sp_search_type* = enum 
    SP_SEARCH_STANDARD = 0, SP_SEARCH_SUGGEST = 1
  sp_playlist_offline_status* = enum 
    SP_PLAYLIST_OFFLINE_STATUS_NO = 0, SP_PLAYLIST_OFFLINE_STATUS_YES = 1, 
    SP_PLAYLIST_OFFLINE_STATUS_DOWNLOADING = 2, 
    SP_PLAYLIST_OFFLINE_STATUS_WAITING = 3
  sp_track_availability* = enum 
    SP_TRACK_AVAILABILITY_UNAVAILABLE = 0, SP_TRACK_AVAILABILITY_AVAILABLE = 1, 
    SP_TRACK_AVAILABILITY_NOT_STREAMABLE = 2, 
    SP_TRACK_AVAILABILITY_BANNED_BY_ARTIST = 3
  sp_track_offline_status* = enum 
    SP_TRACK_OFFLINE_NO = 0, SP_TRACK_OFFLINE_WAITING = 1, 
    SP_TRACK_OFFLINE_DOWNLOADING = 2, SP_TRACK_OFFLINE_DONE = 3, 
    SP_TRACK_OFFLINE_ERROR = 4, SP_TRACK_OFFLINE_DONE_EXPIRED = 5, 
    SP_TRACK_OFFLINE_LIMIT_EXCEEDED = 6, SP_TRACK_OFFLINE_DONE_RESYNC = 7
  sp_image_size* = enum 
    SP_IMAGE_SIZE_NORMAL = 0, SP_IMAGE_SIZE_SMALL = 1, SP_IMAGE_SIZE_LARGE = 2
  sp_audio_buffer_stats* = object 
    samples*: cint
    stutter*: cint

  sp_subscribers* = object 
    count*: cuint
    subscribers*: array[1, cstring]

  sp_connection_type* = enum 
    SP_CONNECTION_TYPE_UNKNOWN = 0, SP_CONNECTION_TYPE_NONE = 1, 
    SP_CONNECTION_TYPE_MOBILE = 2, SP_CONNECTION_TYPE_MOBILE_ROAMING = 3, 
    SP_CONNECTION_TYPE_WIFI = 4, SP_CONNECTION_TYPE_WIRED = 5
  sp_connection_rules* = enum 
    SP_CONNECTION_RULE_NETWORK = 0x00000001, 
    SP_CONNECTION_RULE_NETWORK_IF_ROAMING = 0x00000002, 
    SP_CONNECTION_RULE_ALLOW_SYNC_OVER_MOBILE = 0x00000004, 
    SP_CONNECTION_RULE_ALLOW_SYNC_OVER_WIFI = 0x00000008
  sp_artistbrowse_type* = enum 
    SP_ARTISTBROWSE_FULL,     
    SP_ARTISTBROWSE_NO_TRACKS, 
    SP_ARTISTBROWSE_NO_ALBUMS 
  sp_social_provider* = enum 
    SP_SOCIAL_PROVIDER_SPOTIFY, SP_SOCIAL_PROVIDER_FACEBOOK, 
    SP_SOCIAL_PROVIDER_LASTFM
  sp_scrobbling_state* = enum 
    SP_SCROBBLING_STATE_USE_GLOBAL_SETTING = 0, 
    SP_SCROBBLING_STATE_LOCAL_ENABLED = 1, 
    SP_SCROBBLING_STATE_LOCAL_DISABLED = 2, 
    SP_SCROBBLING_STATE_GLOBAL_ENABLED = 3, 
    SP_SCROBBLING_STATE_GLOBAL_DISABLED = 4
  sp_offline_sync_status* = object 
    queued_tracks*: cint
    queued_bytes*: sp_uint64
    done_tracks*: cint
    done_bytes*: sp_uint64
    copied_tracks*: cint
    copied_bytes*: sp_uint64
    willnotcopy_tracks*: cint
    error_tracks*: cint
    syncing*: bool

  sp_session_callbacks* = object 
    logged_in*: proc (session: ptr sp_session; error: sp_error)
    logged_out*: proc (session: ptr sp_session)
    metadata_updated*: proc (session: ptr sp_session)
    connection_error*: proc (session: ptr sp_session; error: sp_error)
    message_to_user*: proc (session: ptr sp_session; message: cstring)
    notify_main_thread*: proc (session: ptr sp_session)
    music_delivery*: proc (session: ptr sp_session; format: ptr sp_audioformat; 
                           frames: pointer; num_frames: cint): cint
    play_token_lost*: proc (session: ptr sp_session)
    log_message*: proc (session: ptr sp_session; data: cstring)
    end_of_track*: proc (session: ptr sp_session)
    streaming_error*: proc (session: ptr sp_session; error: sp_error)
    userinfo_updated*: proc (session: ptr sp_session)
    start_playback*: proc (session: ptr sp_session)
    stop_playback*: proc (session: ptr sp_session)
    get_audio_buffer_stats*: proc (session: ptr sp_session; 
                                   stats: ptr sp_audio_buffer_stats)
    offline_status_updated*: proc (session: ptr sp_session)
    offline_error*: proc (session: ptr sp_session; error: sp_error)
    credentials_blob_updated*: proc (session: ptr sp_session; blob: cstring)
    connectionstate_updated*: proc (session: ptr sp_session)
    scrobble_error*: proc (session: ptr sp_session; error: sp_error)
    private_session_mode_changed*: proc (session: ptr sp_session; 
        is_private: bool)

  sp_session_config* = object 
    api_version*: cint
    cache_location*: cstring 
    settings_location*: cstring 
    application_key*: pointer
    application_key_size*: csize
    user_agent*: cstring 
    callbacks*: ptr sp_session_callbacks
    userdata*: pointer
    compress_playlists*: bool
    dont_save_metadata_for_playlists*: bool
    initially_unload_playlists*: bool
    device_id*: cstring
    proxy*: cstring
    proxy_username*: cstring
    proxy_password*: cstring
    ca_certs_filename*: cstring
    tracefile*: cstring


proc sp_session_create*(config: ptr sp_session_config; sess: ptr ptr sp_session): sp_error {. cdecl, importc: "sp_session_create", dynlib: sf_dynlib .}
proc sp_session_release*(sess: ptr sp_session): sp_error {. cdecl, importc: "sp_session_release", dynlib: sf_dynlib .}
proc sp_session_login*(session: ptr sp_session; username: cstring; 
                       password: cstring; remember_me: bool; blob: cstring): sp_error {. cdecl, importc: "sp_session_login", dynlib: sf_dynlib .}
proc sp_session_relogin*(session: ptr sp_session): sp_error {. cdecl, importc: "sp_session_relogin", dynlib: sf_dynlib .}
proc sp_session_remembered_user*(session: ptr sp_session; buffer: cstring; 
                                 buffer_size: csize): cint {. cdecl, importc: "sp_session_remembered_user", dynlib: sf_dynlib .}
proc sp_session_user_name*(session: ptr sp_session): cstring {. cdecl, importc: "sp_session_user_name", dynlib: sf_dynlib .}
proc sp_session_forget_me*(session: ptr sp_session): sp_error {. cdecl, importc: "sp_session_forget_me", dynlib: sf_dynlib .}
proc sp_session_user*(session: ptr sp_session): ptr sp_user {. cdecl, importc: "sp_session_user", dynlib: sf_dynlib .}
proc sp_session_logout*(session: ptr sp_session): sp_error {. cdecl, importc: "sp_session_logout", dynlib: sf_dynlib .}
proc sp_session_flush_caches*(session: ptr sp_session): sp_error {. cdecl, importc: "sp_session_flush_caches", dynlib: sf_dynlib .}
proc sp_session_connectionstate*(session: ptr sp_session): sp_connectionstate {. cdecl, importc: "sp_session_connectionstate", dynlib: sf_dynlib .}
proc sp_session_userdata*(session: ptr sp_session): pointer {. cdecl, importc: "sp_session_userdata", dynlib: sf_dynlib .}
proc sp_session_set_cache_size*(session: ptr sp_session; size: csize): sp_error {. cdecl, importc: "sp_session_set_cache_size", dynlib: sf_dynlib .}
proc sp_session_process_events*(session: ptr sp_session; next_timeout: ptr cint): sp_error {. cdecl, importc: "sp_session_process_events", dynlib: sf_dynlib .}
proc sp_session_player_load*(session: ptr sp_session; track: ptr sp_track): sp_error {. cdecl, importc: "sp_session_player_load", dynlib: sf_dynlib .}
proc sp_session_player_seek*(session: ptr sp_session; offset: cint): sp_error {. cdecl, importc: "sp_session_player_seek", dynlib: sf_dynlib .}
proc sp_session_player_play*(session: ptr sp_session; play: bool): sp_error {. cdecl, importc: "sp_session_player_play", dynlib: sf_dynlib .}
proc sp_session_player_unload*(session: ptr sp_session): sp_error {. cdecl, importc: "sp_session_player_unload", dynlib: sf_dynlib .}
proc sp_session_player_prefetch*(session: ptr sp_session; track: ptr sp_track): sp_error {. cdecl, importc: "sp_session_player_prefetch", dynlib: sf_dynlib .}
proc sp_session_playlistcontainer*(session: ptr sp_session): ptr sp_playlistcontainer {. cdecl, importc: "sp_session_playlistcontainer", dynlib: sf_dynlib .}
proc sp_session_inbox_create*(session: ptr sp_session): ptr sp_playlist {. cdecl, importc: "sp_session_inbox_create", dynlib: sf_dynlib .}
proc sp_session_starred_create*(session: ptr sp_session): ptr sp_playlist {. cdecl, importc: "sp_session_starred_create", dynlib: sf_dynlib .}
proc sp_session_starred_for_user_create*(session: ptr sp_session; 
    canonical_username: cstring): ptr sp_playlist {. cdecl, importc: "sp_session_starred_for_user_create", dynlib: sf_dynlib .}
proc sp_session_publishedcontainer_for_user_create*(session: ptr sp_session; 
    canonical_username: cstring): ptr sp_playlistcontainer {. cdecl, importc: "sp_session_publishedcontainer_for_user_create", dynlib: sf_dynlib .}
proc sp_session_preferred_bitrate*(session: ptr sp_session; bitrate: sp_bitrate): sp_error {. cdecl, importc: "sp_session_preferred_bitrate", dynlib: sf_dynlib .}
proc sp_session_preferred_offline_bitrate*(session: ptr sp_session; 
    bitrate: sp_bitrate; allow_resync: bool): sp_error {. cdecl, importc: "sp_session_preferred_offline_bitrate", dynlib: sf_dynlib .}
proc sp_session_get_volume_normalization*(session: ptr sp_session): bool {. cdecl, importc: "sp_session_get_volume_normalization", dynlib: sf_dynlib .}
proc sp_session_set_volume_normalization*(session: ptr sp_session; on: bool): sp_error {. cdecl, importc: "sp_session_set_volume_normalization", dynlib: sf_dynlib .}
proc sp_session_set_private_session*(session: ptr sp_session; enabled: bool): sp_error {. cdecl, importc: "sp_session_set_private_session", dynlib: sf_dynlib .}
proc sp_session_is_private_session*(session: ptr sp_session): bool {. cdecl, importc: "sp_session_is_private_session", dynlib: sf_dynlib .}
proc sp_session_set_scrobbling*(session: ptr sp_session; 
                                provider: sp_social_provider; 
                                state: sp_scrobbling_state): sp_error {. cdecl, importc: "sp_session_set_scrobbling", dynlib: sf_dynlib .}
proc sp_session_is_scrobbling*(session: ptr sp_session; 
                               provider: sp_social_provider; 
                               state: ptr sp_scrobbling_state): sp_error {. cdecl, importc: "sp_session_is_scrobbling", dynlib: sf_dynlib .}
proc sp_session_is_scrobbling_possible*(session: ptr sp_session; 
                                        provider: sp_social_provider; 
                                        `out`: ptr bool): sp_error {. cdecl, importc: "sp_session_is_scrobbling_possible", dynlib: sf_dynlib .}
proc sp_session_set_social_credentials*(session: ptr sp_session; 
                                        provider: sp_social_provider; 
                                        username: cstring; password: cstring): sp_error {. cdecl, importc: "sp_session_set_social_credentials", dynlib: sf_dynlib .}
proc sp_session_set_connection_type*(session: ptr sp_session; 
                                     `type`: sp_connection_type): sp_error {. cdecl, importc: "sp_session_set_connection_type", dynlib: sf_dynlib .}
proc sp_session_set_connection_rules*(session: ptr sp_session; 
                                      rules: sp_connection_rules): sp_error {. cdecl, importc: "sp_session_set_connection_rules", dynlib: sf_dynlib .}
proc sp_offline_tracks_to_sync*(session: ptr sp_session): cint {. cdecl, importc: "sp_offline_tracks_to_sync", dynlib: sf_dynlib .}
proc sp_offline_num_playlists*(session: ptr sp_session): cint {. cdecl, importc: "sp_offline_num_playlists", dynlib: sf_dynlib .}
proc sp_offline_sync_get_status*(session: ptr sp_session; 
                                 status: ptr sp_offline_sync_status): bool {. cdecl, importc: "sp_offline_sync_get_status", dynlib: sf_dynlib .}
proc sp_offline_time_left*(session: ptr sp_session): cint {. cdecl, importc: "sp_offline_time_left", dynlib: sf_dynlib .}
proc sp_session_user_country*(session: ptr sp_session): cint {. cdecl, importc: "sp_session_user_country", dynlib: sf_dynlib .}
type 
  sp_linktype* = enum 
    SP_LINKTYPE_INVALID = 0, SP_LINKTYPE_TRACK = 1, SP_LINKTYPE_ALBUM = 2, 
    SP_LINKTYPE_ARTIST = 3, SP_LINKTYPE_SEARCH = 4, SP_LINKTYPE_PLAYLIST = 5, 
    SP_LINKTYPE_PROFILE = 6, SP_LINKTYPE_STARRED = 7, 
    SP_LINKTYPE_LOCALTRACK = 8, SP_LINKTYPE_IMAGE = 9


proc sp_link_create_from_string*(link: cstring): ptr sp_link {. cdecl, importc: "sp_link_create_from_string", dynlib: sf_dynlib .}
proc sp_link_create_from_track*(track: ptr sp_track; offset: cint): ptr sp_link {. cdecl, importc: "sp_link_create_from_track", dynlib: sf_dynlib .}
proc sp_link_create_from_album*(album: ptr sp_album): ptr sp_link {. cdecl, importc: "sp_link_create_from_album", dynlib: sf_dynlib .}
proc sp_link_create_from_album_cover*(album: ptr sp_album; size: sp_image_size): ptr sp_link {. cdecl, importc: "sp_link_create_from_album_cover", dynlib: sf_dynlib .}
proc sp_link_create_from_artist*(artist: ptr sp_artist): ptr sp_link {. cdecl, importc: "sp_link_create_from_artist", dynlib: sf_dynlib .}
proc sp_link_create_from_artist_portrait*(artist: ptr sp_artist; 
    size: sp_image_size): ptr sp_link {. cdecl, importc: "sp_link_create_from_artist_portrait", dynlib: sf_dynlib .}
proc sp_link_create_from_artistbrowse_portrait*(arb: ptr sp_artistbrowse; 
    index: cint): ptr sp_link {. cdecl, importc: "sp_link_create_from_artistbrowse_portrait", dynlib: sf_dynlib .}
proc sp_link_create_from_search*(search: ptr sp_search): ptr sp_link {. cdecl, importc: "sp_link_create_from_search", dynlib: sf_dynlib .}
proc sp_link_create_from_playlist*(playlist: ptr sp_playlist): ptr sp_link {. cdecl, importc: "sp_link_create_from_playlist", dynlib: sf_dynlib .}
proc sp_link_create_from_user*(user: ptr sp_user): ptr sp_link {. cdecl, importc: "sp_link_create_from_user", dynlib: sf_dynlib .}
proc sp_link_create_from_image*(image: ptr sp_image): ptr sp_link {. cdecl, importc: "sp_link_create_from_image", dynlib: sf_dynlib .}
proc sp_link_as_string*(link: ptr sp_link; buffer: cstring; buffer_size: cint): cint {. cdecl, importc: "sp_link_as_string", dynlib: sf_dynlib .}
proc sp_link_type_get*(link: ptr sp_link): sp_linktype {. cdecl, importc: "sp_link_type", dynlib: sf_dynlib .}
proc sp_link_as_track*(link: ptr sp_link): ptr sp_track {. cdecl, importc: "sp_link_as_track", dynlib: sf_dynlib .}
proc sp_link_as_track_and_offset*(link: ptr sp_link; offset: ptr cint): ptr sp_track {. cdecl, importc: "sp_link_as_track_and_offset", dynlib: sf_dynlib .}
proc sp_link_as_album*(link: ptr sp_link): ptr sp_album {. cdecl, importc: "sp_link_as_album", dynlib: sf_dynlib .}
proc sp_link_as_artist*(link: ptr sp_link): ptr sp_artist {. cdecl, importc: "sp_link_as_artist", dynlib: sf_dynlib .}
proc sp_link_as_user*(link: ptr sp_link): ptr sp_user {. cdecl, importc: "sp_link_as_user", dynlib: sf_dynlib .}
proc sp_link_add_ref*(link: ptr sp_link): sp_error {. cdecl, importc: "sp_link_add_ref", dynlib: sf_dynlib .}
proc sp_link_release*(link: ptr sp_link): sp_error {. cdecl, importc: "sp_link_release", dynlib: sf_dynlib .}
proc sp_track_is_loaded*(track: ptr sp_track): bool {. cdecl, importc: "sp_track_is_loaded", dynlib: sf_dynlib .}
proc sp_track_error*(track: ptr sp_track): sp_error {. cdecl, importc: "sp_track_error", dynlib: sf_dynlib .}
proc sp_track_offline_get_status*(track: ptr sp_track): sp_track_offline_status {. cdecl, importc: "sp_track_offline_get_status", dynlib: sf_dynlib .}
proc sp_track_get_availability*(session: ptr sp_session; track: ptr sp_track): sp_track_availability {. cdecl, importc: "sp_track_get_availability", dynlib: sf_dynlib .}
proc sp_track_is_local*(session: ptr sp_session; track: ptr sp_track): bool {. cdecl, importc: "sp_track_is_local", dynlib: sf_dynlib .}
proc sp_track_is_autolinked*(session: ptr sp_session; track: ptr sp_track): bool {. cdecl, importc: "sp_track_is_autolinked", dynlib: sf_dynlib .}
proc sp_track_get_playable*(session: ptr sp_session; track: ptr sp_track): ptr sp_track {. cdecl, importc: "sp_track_get_playable", dynlib: sf_dynlib .}
proc sp_track_is_placeholder*(track: ptr sp_track): bool {. cdecl, importc: "sp_track_is_placeholder", dynlib: sf_dynlib .}
proc sp_track_is_starred*(session: ptr sp_session; track: ptr sp_track): bool {. cdecl, importc: "sp_track_is_starred", dynlib: sf_dynlib .}
proc sp_track_set_starred*(session: ptr sp_session; tracks: ptr ptr sp_track; 
                           num_tracks: cint; star: bool): sp_error {. cdecl, importc: "sp_track_set_starred", dynlib: sf_dynlib .}
proc sp_track_num_artists*(track: ptr sp_track): cint {. cdecl, importc: "sp_track_num_artists", dynlib: sf_dynlib .}
proc sp_track_artist*(track: ptr sp_track; index: cint): ptr sp_artist {. cdecl, importc: "sp_track_artist", dynlib: sf_dynlib .}
proc sp_track_album*(track: ptr sp_track): ptr sp_album {. cdecl, importc: "sp_track_album", dynlib: sf_dynlib .}
proc sp_track_name*(track: ptr sp_track): cstring {. cdecl, importc: "sp_track_name", dynlib: sf_dynlib .}
proc sp_track_duration*(track: ptr sp_track): cint {. cdecl, importc: "sp_track_duration", dynlib: sf_dynlib .}
proc sp_track_popularity*(track: ptr sp_track): cint {. cdecl, importc: "sp_track_popularity", dynlib: sf_dynlib .}
proc sp_track_disc*(track: ptr sp_track): cint {. cdecl, importc: "sp_track_disc", dynlib: sf_dynlib .}
proc sp_track_index*(track: ptr sp_track): cint {. cdecl, importc: "sp_track_index", dynlib: sf_dynlib .}
proc sp_localtrack_create*(artist: cstring; title: cstring; album: cstring; 
                           length: cint): ptr sp_track {. cdecl, importc: "sp_localtrack_create", dynlib: sf_dynlib .}
proc sp_track_add_ref*(track: ptr sp_track): sp_error {. cdecl, importc: "sp_track_add_ref", dynlib: sf_dynlib .}
proc sp_track_release*(track: ptr sp_track): sp_error {. cdecl, importc: "sp_track_release", dynlib: sf_dynlib .}
type 
  sp_albumtype* = enum 
    SP_ALBUMTYPE_ALBUM = 0, SP_ALBUMTYPE_SINGLE = 1, 
    SP_ALBUMTYPE_COMPILATION = 2, SP_ALBUMTYPE_UNKNOWN = 3


proc sp_album_is_loaded*(album: ptr sp_album): bool {. cdecl, importc: "sp_album_is_loaded", dynlib: sf_dynlib .}
proc sp_album_is_available*(album: ptr sp_album): bool {. cdecl, importc: "sp_album_is_available", dynlib: sf_dynlib .}
proc sp_album_artist*(album: ptr sp_album): ptr sp_artist {. cdecl, importc: "sp_album_artist", dynlib: sf_dynlib .}
proc sp_album_cover*(album: ptr sp_album; size: sp_image_size): ptr byte {. cdecl, importc: "sp_album_cover", dynlib: sf_dynlib .}
proc sp_album_name*(album: ptr sp_album): cstring {. cdecl, importc: "sp_album_name", dynlib: sf_dynlib .}
proc sp_album_year*(album: ptr sp_album): cint {. cdecl, importc: "sp_album_year", dynlib: sf_dynlib .}
proc sp_album_type_get*(album: ptr sp_album): sp_albumtype {. cdecl, importc: "sp_album_type", dynlib: sf_dynlib .}
proc sp_album_add_ref*(album: ptr sp_album): sp_error {. cdecl, importc: "sp_album_add_ref", dynlib: sf_dynlib .}
proc sp_album_release*(album: ptr sp_album): sp_error {. cdecl, importc: "sp_album_release", dynlib: sf_dynlib .}
proc sp_artist_name*(artist: ptr sp_artist): cstring {. cdecl, importc: "sp_artist_name", dynlib: sf_dynlib .}
proc sp_artist_is_loaded*(artist: ptr sp_artist): bool {. cdecl, importc: "sp_artist_is_loaded", dynlib: sf_dynlib .}
proc sp_artist_portrait*(artist: ptr sp_artist; size: sp_image_size): ptr byte {. cdecl, importc: "sp_artist_portrait", dynlib: sf_dynlib .}
proc sp_artist_add_ref*(artist: ptr sp_artist): sp_error {. cdecl, importc: "sp_artist_add_ref", dynlib: sf_dynlib .}
proc sp_artist_release*(artist: ptr sp_artist): sp_error {. cdecl, importc: "sp_artist_release", dynlib: sf_dynlib .}
type 
  albumbrowse_complete_cb* = proc (result: ptr sp_albumbrowse; userdata: pointer)

proc sp_albumbrowse_create*(session: ptr sp_session; album: ptr sp_album; 
                            callback: ptr albumbrowse_complete_cb; 
                            userdata: pointer): ptr sp_albumbrowse {. cdecl, importc: "sp_albumbrowse_create", dynlib: sf_dynlib .}
proc sp_albumbrowse_is_loaded*(alb: ptr sp_albumbrowse): bool {. cdecl, importc: "sp_albumbrowse_is_loaded", dynlib: sf_dynlib .}
proc sp_albumbrowse_error*(alb: ptr sp_albumbrowse): sp_error {. cdecl, importc: "sp_albumbrowse_error", dynlib: sf_dynlib .}
proc sp_albumbrowse_album*(alb: ptr sp_albumbrowse): ptr sp_album {. cdecl, importc: "sp_albumbrowse_album", dynlib: sf_dynlib .}
proc sp_albumbrowse_artist*(alb: ptr sp_albumbrowse): ptr sp_artist {. cdecl, importc: "sp_albumbrowse_artist", dynlib: sf_dynlib .}
proc sp_albumbrowse_num_copyrights*(alb: ptr sp_albumbrowse): cint {. cdecl, importc: "sp_albumbrowse_num_copyrights", dynlib: sf_dynlib .}
proc sp_albumbrowse_copyright*(alb: ptr sp_albumbrowse; index: cint): cstring {. cdecl, importc: "sp_albumbrowse_copyright", dynlib: sf_dynlib .}
proc sp_albumbrowse_num_tracks*(alb: ptr sp_albumbrowse): cint {. cdecl, importc: "sp_albumbrowse_num_tracks", dynlib: sf_dynlib .}
proc sp_albumbrowse_track*(alb: ptr sp_albumbrowse; index: cint): ptr sp_track {. cdecl, importc: "sp_albumbrowse_track", dynlib: sf_dynlib .}
proc sp_albumbrowse_review*(alb: ptr sp_albumbrowse): cstring {. cdecl, importc: "sp_albumbrowse_review", dynlib: sf_dynlib .}
proc sp_albumbrowse_backend_request_duration*(alb: ptr sp_albumbrowse): cint {. cdecl, importc: "sp_albumbrowse_backend_request_duration", dynlib: sf_dynlib .}
proc sp_albumbrowse_add_ref*(alb: ptr sp_albumbrowse): sp_error {. cdecl, importc: "sp_albumbrowse_add_ref", dynlib: sf_dynlib .}
proc sp_albumbrowse_release*(alb: ptr sp_albumbrowse): sp_error {. cdecl, importc: "sp_albumbrowse_release", dynlib: sf_dynlib .}
type 
  artistbrowse_complete_cb* = proc (result: ptr sp_artistbrowse; 
                                    userdata: pointer)

proc sp_artistbrowse_create*(session: ptr sp_session; artist: ptr sp_artist; 
                             `type`: sp_artistbrowse_type; 
                             callback: ptr artistbrowse_complete_cb; 
                             userdata: pointer): ptr sp_artistbrowse {. cdecl, importc: "sp_artistbrowse_create", dynlib: sf_dynlib .}
proc sp_artistbrowse_is_loaded*(arb: ptr sp_artistbrowse): bool {. cdecl, importc: "sp_artistbrowse_is_loaded", dynlib: sf_dynlib .}
proc sp_artistbrowse_error*(arb: ptr sp_artistbrowse): sp_error {. cdecl, importc: "sp_artistbrowse_error", dynlib: sf_dynlib .}
proc sp_artistbrowse_artist*(arb: ptr sp_artistbrowse): ptr sp_artist {. cdecl, importc: "sp_artistbrowse_artist", dynlib: sf_dynlib .}
proc sp_artistbrowse_num_portraits*(arb: ptr sp_artistbrowse): cint {. cdecl, importc: "sp_artistbrowse_num_portraits", dynlib: sf_dynlib .}
proc sp_artistbrowse_portrait*(arb: ptr sp_artistbrowse; index: cint): ptr byte {. cdecl, importc: "sp_artistbrowse_portrait", dynlib: sf_dynlib .}
proc sp_artistbrowse_num_tracks*(arb: ptr sp_artistbrowse): cint {. cdecl, importc: "sp_artistbrowse_num_tracks", dynlib: sf_dynlib .}
proc sp_artistbrowse_track*(arb: ptr sp_artistbrowse; index: cint): ptr sp_track {. cdecl, importc: "sp_artistbrowse_track", dynlib: sf_dynlib .}
proc sp_artistbrowse_num_tophit_tracks*(arb: ptr sp_artistbrowse): cint {. cdecl, importc: "sp_artistbrowse_num_tophit_tracks", dynlib: sf_dynlib .}
proc sp_artistbrowse_tophit_track*(arb: ptr sp_artistbrowse; index: cint): ptr sp_track {. cdecl, importc: "sp_artistbrowse_tophit_track", dynlib: sf_dynlib .}
proc sp_artistbrowse_num_albums*(arb: ptr sp_artistbrowse): cint {. cdecl, importc: "sp_artistbrowse_num_albums", dynlib: sf_dynlib .}
proc sp_artistbrowse_album*(arb: ptr sp_artistbrowse; index: cint): ptr sp_album {. cdecl, importc: "sp_artistbrowse_album", dynlib: sf_dynlib .}
proc sp_artistbrowse_num_similar_artists*(arb: ptr sp_artistbrowse): cint {. cdecl, importc: "sp_artistbrowse_num_similar_artists", dynlib: sf_dynlib .}
proc sp_artistbrowse_similar_artist*(arb: ptr sp_artistbrowse; index: cint): ptr sp_artist {. cdecl, importc: "sp_artistbrowse_similar_artist", dynlib: sf_dynlib .}
proc sp_artistbrowse_biography*(arb: ptr sp_artistbrowse): cstring {. cdecl, importc: "sp_artistbrowse_biography", dynlib: sf_dynlib .}
proc sp_artistbrowse_backend_request_duration*(arb: ptr sp_artistbrowse): cint {. cdecl, importc: "sp_artistbrowse_backend_request_duration", dynlib: sf_dynlib .}
proc sp_artistbrowse_add_ref*(arb: ptr sp_artistbrowse): sp_error {. cdecl, importc: "sp_artistbrowse_add_ref", dynlib: sf_dynlib .}
proc sp_artistbrowse_release*(arb: ptr sp_artistbrowse): sp_error {. cdecl, importc: "sp_artistbrowse_release", dynlib: sf_dynlib .}
type 
  sp_imageformat* = enum 
    SP_IMAGE_FORMAT_UNKNOWN = - 1, SP_IMAGE_FORMAT_JPEG = 0
  image_loaded_cb* = proc (image: ptr sp_image; userdata: pointer)


proc sp_image_create*(session: ptr sp_session; image_id: array[20, byte]): ptr sp_image {. cdecl, importc: "sp_image_create", dynlib: sf_dynlib .}
proc sp_image_create_from_link*(session: ptr sp_session; link: ptr sp_link): ptr sp_image {. cdecl, importc: "sp_image_create_from_link", dynlib: sf_dynlib .}
proc sp_image_add_load_callback*(image: ptr sp_image; 
                                 callback: ptr image_loaded_cb; 
                                 userdata: pointer): sp_error {. cdecl, importc: "sp_image_add_load_callback", dynlib: sf_dynlib .}
proc sp_image_remove_load_callback*(image: ptr sp_image; 
                                    callback: ptr image_loaded_cb; 
                                    userdata: pointer): sp_error {. cdecl, importc: "sp_image_remove_load_callback", dynlib: sf_dynlib .}
proc sp_image_is_loaded*(image: ptr sp_image): bool {. cdecl, importc: "sp_image_is_loaded", dynlib: sf_dynlib .}
proc sp_image_error*(image: ptr sp_image): sp_error {. cdecl, importc: "sp_image_error", dynlib: sf_dynlib .}
proc sp_image_format_get*(image: ptr sp_image): sp_imageformat {. cdecl, importc: "sp_image_format", dynlib: sf_dynlib .}
proc sp_image_data*(image: ptr sp_image; data_size: ptr csize): pointer {. cdecl, importc: "sp_image_data", dynlib: sf_dynlib .}
proc sp_image_image_id*(image: ptr sp_image): ptr byte {. cdecl, importc: "sp_image_image_id", dynlib: sf_dynlib .}
proc sp_image_add_ref*(image: ptr sp_image): sp_error {. cdecl, importc: "sp_image_add_ref", dynlib: sf_dynlib .}
proc sp_image_release*(image: ptr sp_image): sp_error {. cdecl, importc: "sp_image_release", dynlib: sf_dynlib .}
type 
  search_complete_cb* = proc (result: ptr sp_search; userdata: pointer)

proc sp_search_create*(session: ptr sp_session; query: cstring; 
                       track_offset: cint; track_count: cint; 
                       album_offset: cint; album_count: cint; 
                       artist_offset: cint; artist_count: cint; 
                       playlist_offset: cint; playlist_count: cint; 
                       search_type: sp_search_type; 
                       callback: ptr search_complete_cb; userdata: pointer): ptr sp_search {. cdecl, importc: "sp_search_create", dynlib: sf_dynlib .}
proc sp_search_is_loaded*(search: ptr sp_search): bool {. cdecl, importc: "sp_search_is_loaded", dynlib: sf_dynlib .}
proc sp_search_error*(search: ptr sp_search): sp_error {. cdecl, importc: "sp_search_error", dynlib: sf_dynlib .}
proc sp_search_num_tracks*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_num_tracks", dynlib: sf_dynlib .}
proc sp_search_track*(search: ptr sp_search; index: cint): ptr sp_track {. cdecl, importc: "sp_search_track", dynlib: sf_dynlib .}
proc sp_search_num_albums*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_num_albums", dynlib: sf_dynlib .}
proc sp_search_album*(search: ptr sp_search; index: cint): ptr sp_album {. cdecl, importc: "sp_search_album", dynlib: sf_dynlib .}
proc sp_search_num_playlists*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_num_playlists", dynlib: sf_dynlib .}
proc sp_search_playlist*(search: ptr sp_search; index: cint): ptr sp_playlist {. cdecl, importc: "sp_search_playlist", dynlib: sf_dynlib .}
proc sp_search_playlist_name*(search: ptr sp_search; index: cint): cstring {. cdecl, importc: "sp_search_playlist_name", dynlib: sf_dynlib .}
proc sp_search_playlist_uri*(search: ptr sp_search; index: cint): cstring {. cdecl, importc: "sp_search_playlist_uri", dynlib: sf_dynlib .}
proc sp_search_playlist_image_uri*(search: ptr sp_search; index: cint): cstring {. cdecl, importc: "sp_search_playlist_image_uri", dynlib: sf_dynlib .}
proc sp_search_num_artists*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_num_artists", dynlib: sf_dynlib .}
proc sp_search_artist*(search: ptr sp_search; index: cint): ptr sp_artist {. cdecl, importc: "sp_search_artist", dynlib: sf_dynlib .}
proc sp_search_query*(search: ptr sp_search): cstring {. cdecl, importc: "sp_search_query", dynlib: sf_dynlib .}
proc sp_search_did_you_mean*(search: ptr sp_search): cstring {. cdecl, importc: "sp_search_did_you_mean", dynlib: sf_dynlib .}
proc sp_search_total_tracks*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_total_tracks", dynlib: sf_dynlib .}
proc sp_search_total_albums*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_total_albums", dynlib: sf_dynlib .}
proc sp_search_total_artists*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_total_artists", dynlib: sf_dynlib .}
proc sp_search_total_playlists*(search: ptr sp_search): cint {. cdecl, importc: "sp_search_total_playlists", dynlib: sf_dynlib .}
proc sp_search_add_ref*(search: ptr sp_search): sp_error {. cdecl, importc: "sp_search_add_ref", dynlib: sf_dynlib .}
proc sp_search_release*(search: ptr sp_search): sp_error {. cdecl, importc: "sp_search_release", dynlib: sf_dynlib .}
type 
  sp_playlist_callbacks* = object 
    tracks_added*: proc (pl: ptr sp_playlist; tracks: ptr ptr sp_track; 
                         num_tracks: cint; position: cint; userdata: pointer)
    tracks_removed*: proc (pl: ptr sp_playlist; tracks: ptr cint; 
                           num_tracks: cint; userdata: pointer)
    tracks_moved*: proc (pl: ptr sp_playlist; tracks: ptr cint; 
                         num_tracks: cint; new_position: cint; userdata: pointer)
    playlist_renamed*: proc (pl: ptr sp_playlist; userdata: pointer)
    playlist_state_changed*: proc (pl: ptr sp_playlist; userdata: pointer)
    playlist_update_in_progress*: proc (pl: ptr sp_playlist; done: bool; 
                                        userdata: pointer)
    playlist_metadata_updated*: proc (pl: ptr sp_playlist; userdata: pointer)
    track_created_changed*: proc (pl: ptr sp_playlist; position: cint; 
                                  user: ptr sp_user; `when`: cint; 
                                  userdata: pointer)
    track_seen_changed*: proc (pl: ptr sp_playlist; position: cint; seen: bool; 
                               userdata: pointer)
    description_changed*: proc (pl: ptr sp_playlist; desc: cstring; 
                                userdata: pointer)
    image_changed*: proc (pl: ptr sp_playlist; image: ptr byte; 
                          userdata: pointer)
    track_message_changed*: proc (pl: ptr sp_playlist; position: cint; 
                                  message: cstring; userdata: pointer)
    subscribers_changed*: proc (pl: ptr sp_playlist; userdata: pointer)


proc sp_playlist_is_loaded*(playlist: ptr sp_playlist): bool {. cdecl, importc: "sp_playlist_is_loaded", dynlib: sf_dynlib .}
proc sp_playlist_add_callbacks*(playlist: ptr sp_playlist; 
                                callbacks: ptr sp_playlist_callbacks; 
                                userdata: pointer): sp_error {. cdecl, importc: "sp_playlist_add_callbacks", dynlib: sf_dynlib .}
proc sp_playlist_remove_callbacks*(playlist: ptr sp_playlist; 
                                   callbacks: ptr sp_playlist_callbacks; 
                                   userdata: pointer): sp_error {. cdecl, importc: "sp_playlist_remove_callbacks", dynlib: sf_dynlib .}
proc sp_playlist_num_tracks*(playlist: ptr sp_playlist): cint {. cdecl, importc: "sp_playlist_num_tracks", dynlib: sf_dynlib .}
proc sp_playlist_track*(playlist: ptr sp_playlist; index: cint): ptr sp_track {. cdecl, importc: "sp_playlist_track", dynlib: sf_dynlib .}
proc sp_playlist_track_create_time*(playlist: ptr sp_playlist; index: cint): cint {. cdecl, importc: "sp_playlist_track_create_time", dynlib: sf_dynlib .}
proc sp_playlist_track_creator*(playlist: ptr sp_playlist; index: cint): ptr sp_user {. cdecl, importc: "sp_playlist_track_creator", dynlib: sf_dynlib .}
proc sp_playlist_track_seen*(playlist: ptr sp_playlist; index: cint): bool {. cdecl, importc: "sp_playlist_track_seen", dynlib: sf_dynlib .}
proc sp_playlist_track_set_seen*(playlist: ptr sp_playlist; index: cint; 
                                 seen: bool): sp_error {. cdecl, importc: "sp_playlist_track_set_seen", dynlib: sf_dynlib .}
proc sp_playlist_track_message*(playlist: ptr sp_playlist; index: cint): cstring {. cdecl, importc: "sp_playlist_track_message", dynlib: sf_dynlib .}
proc sp_playlist_name*(playlist: ptr sp_playlist): cstring {. cdecl, importc: "sp_playlist_name", dynlib: sf_dynlib .}
proc sp_playlist_rename*(playlist: ptr sp_playlist; new_name: cstring): sp_error {. cdecl, importc: "sp_playlist_rename", dynlib: sf_dynlib .}
proc sp_playlist_owner*(playlist: ptr sp_playlist): ptr sp_user {. cdecl, importc: "sp_playlist_owner", dynlib: sf_dynlib .}
proc sp_playlist_is_collaborative*(playlist: ptr sp_playlist): bool {. cdecl, importc: "sp_playlist_is_collaborative", dynlib: sf_dynlib .}
proc sp_playlist_set_collaborative*(playlist: ptr sp_playlist; 
                                    collaborative: bool): sp_error {. cdecl, importc: "sp_playlist_set_collaborative", dynlib: sf_dynlib .}
proc sp_playlist_set_autolink_tracks*(playlist: ptr sp_playlist; link: bool): sp_error {. cdecl, importc: "sp_playlist_set_autolink_tracks", dynlib: sf_dynlib .}
proc sp_playlist_get_description*(playlist: ptr sp_playlist): cstring {. cdecl, importc: "sp_playlist_get_description", dynlib: sf_dynlib .}
proc sp_playlist_get_image*(playlist: ptr sp_playlist; image: array[20, byte]): bool {. cdecl, importc: "sp_playlist_get_image", dynlib: sf_dynlib .}
proc sp_playlist_has_pending_changes*(playlist: ptr sp_playlist): bool {. cdecl, importc: "sp_playlist_has_pending_changes", dynlib: sf_dynlib .}
proc sp_playlist_add_tracks*(playlist: ptr sp_playlist; 
                             tracks: ptr ptr sp_track; num_tracks: cint; 
                             position: cint; session: ptr sp_session): sp_error {. cdecl, importc: "sp_playlist_add_tracks", dynlib: sf_dynlib .}
proc sp_playlist_remove_tracks*(playlist: ptr sp_playlist; tracks: ptr cint; 
                                num_tracks: cint): sp_error {. cdecl, importc: "sp_playlist_remove_tracks", dynlib: sf_dynlib .}
proc sp_playlist_reorder_tracks*(playlist: ptr sp_playlist; tracks: ptr cint; 
                                 num_tracks: cint; new_position: cint): sp_error {. cdecl, importc: "sp_playlist_reorder_tracks", dynlib: sf_dynlib .}
proc sp_playlist_num_subscribers*(playlist: ptr sp_playlist): cuint {. cdecl, importc: "sp_playlist_num_subscribers", dynlib: sf_dynlib .}
proc sp_playlist_subscribers*(playlist: ptr sp_playlist): ptr sp_subscribers {. cdecl, importc: "sp_playlist_subscribers", dynlib: sf_dynlib .}
proc sp_playlist_subscribers_free*(subscribers: ptr sp_subscribers): sp_error {. cdecl, importc: "sp_playlist_subscribers_free", dynlib: sf_dynlib .}
proc sp_playlist_update_subscribers*(session: ptr sp_session; 
                                     playlist: ptr sp_playlist): sp_error {. cdecl, importc: "sp_playlist_update_subscribers", dynlib: sf_dynlib .}
proc sp_playlist_is_in_ram*(session: ptr sp_session; playlist: ptr sp_playlist): bool {. cdecl, importc: "sp_playlist_is_in_ram", dynlib: sf_dynlib .}
proc sp_playlist_set_in_ram*(session: ptr sp_session; playlist: ptr sp_playlist; 
                             in_ram: bool): sp_error {. cdecl, importc: "sp_playlist_set_in_ram", dynlib: sf_dynlib .}
proc sp_playlist_create*(session: ptr sp_session; link: ptr sp_link): ptr sp_playlist {. cdecl, importc: "sp_playlist_create", dynlib: sf_dynlib .}
proc sp_playlist_set_offline_mode*(session: ptr sp_session; 
                                   playlist: ptr sp_playlist; offline: bool): sp_error {. cdecl, importc: "sp_playlist_set_offline_mode", dynlib: sf_dynlib .}
proc sp_playlist_get_offline_status*(session: ptr sp_session; 
                                     playlist: ptr sp_playlist): sp_playlist_offline_status {. cdecl, importc: "sp_playlist_get_offline_status", dynlib: sf_dynlib .}
proc sp_playlist_get_offline_download_completed*(session: ptr sp_session; 
    playlist: ptr sp_playlist): cint {. cdecl, importc: "sp_playlist_get_offline_download_completed", dynlib: sf_dynlib .}
proc sp_playlist_add_ref*(playlist: ptr sp_playlist): sp_error {. cdecl, importc: "sp_playlist_add_ref", dynlib: sf_dynlib .}
proc sp_playlist_release*(playlist: ptr sp_playlist): sp_error {. cdecl, importc: "sp_playlist_release", dynlib: sf_dynlib .}
type 
  sp_playlistcontainer_callbacks* = object 
    playlist_added*: proc (pc: ptr sp_playlistcontainer; 
                           playlist: ptr sp_playlist; position: cint; 
                           userdata: pointer)
    playlist_removed*: proc (pc: ptr sp_playlistcontainer; 
                             playlist: ptr sp_playlist; position: cint; 
                             userdata: pointer)
    playlist_moved*: proc (pc: ptr sp_playlistcontainer; 
                           playlist: ptr sp_playlist; position: cint; 
                           new_position: cint; userdata: pointer)
    container_loaded*: proc (pc: ptr sp_playlistcontainer; userdata: pointer)


proc sp_playlistcontainer_add_callbacks*(pc: ptr sp_playlistcontainer; 
    callbacks: ptr sp_playlistcontainer_callbacks; userdata: pointer): sp_error {. cdecl, importc: "sp_playlistcontainer_add_callbacks", dynlib: sf_dynlib .}
proc sp_playlistcontainer_remove_callbacks*(pc: ptr sp_playlistcontainer; 
    callbacks: ptr sp_playlistcontainer_callbacks; userdata: pointer): sp_error {. cdecl, importc: "sp_playlistcontainer_remove_callbacks", dynlib: sf_dynlib .}
proc sp_playlistcontainer_num_playlists*(pc: ptr sp_playlistcontainer): cint {. cdecl, importc: "sp_playlistcontainer_num_playlists", dynlib: sf_dynlib .}
proc sp_playlistcontainer_is_loaded*(pc: ptr sp_playlistcontainer): bool {. cdecl, importc: "sp_playlistcontainer_is_loaded", dynlib: sf_dynlib .}
proc sp_playlistcontainer_playlist*(pc: ptr sp_playlistcontainer; index: cint): ptr sp_playlist {. cdecl, importc: "sp_playlistcontainer_playlist", dynlib: sf_dynlib .}
proc sp_playlistcontainer_playlist_type*(pc: ptr sp_playlistcontainer; 
    index: cint): sp_playlist_type {. cdecl, importc: "sp_playlistcontainer_playlist_type", dynlib: sf_dynlib .}
proc sp_playlistcontainer_playlist_folder_name*(pc: ptr sp_playlistcontainer; 
    index: cint; buffer: cstring; buffer_size: cint): sp_error {. cdecl, importc: "sp_playlistcontainer_playlist_folder_name", dynlib: sf_dynlib .}
proc sp_playlistcontainer_playlist_folder_id*(pc: ptr sp_playlistcontainer; 
    index: cint): sp_uint64 {. cdecl, importc: "sp_playlistcontainer_playlist_folder_id", dynlib: sf_dynlib .}
proc sp_playlistcontainer_add_new_playlist*(pc: ptr sp_playlistcontainer; 
    name: cstring): ptr sp_playlist {. cdecl, importc: "sp_playlistcontainer_add_new_playlist", dynlib: sf_dynlib .}
proc sp_playlistcontainer_add_playlist*(pc: ptr sp_playlistcontainer; 
                                        link: ptr sp_link): ptr sp_playlist {. cdecl, importc: "sp_playlistcontainer_add_playlist", dynlib: sf_dynlib .}
proc sp_playlistcontainer_remove_playlist*(pc: ptr sp_playlistcontainer; 
    index: cint): sp_error {. cdecl, importc: "sp_playlistcontainer_remove_playlist", dynlib: sf_dynlib .}
proc sp_playlistcontainer_move_playlist*(pc: ptr sp_playlistcontainer; 
    index: cint; new_position: cint; dry_run: bool): sp_error {. cdecl, importc: "sp_playlistcontainer_move_playlist", dynlib: sf_dynlib .}
proc sp_playlistcontainer_add_folder*(pc: ptr sp_playlistcontainer; index: cint; 
                                      name: cstring): sp_error {. cdecl, importc: "sp_playlistcontainer_add_folder", dynlib: sf_dynlib .}
proc sp_playlistcontainer_owner*(pc: ptr sp_playlistcontainer): ptr sp_user {. cdecl, importc: "sp_playlistcontainer_owner", dynlib: sf_dynlib .}
proc sp_playlistcontainer_add_ref*(pc: ptr sp_playlistcontainer): sp_error {. cdecl, importc: "sp_playlistcontainer_add_ref", dynlib: sf_dynlib .}
proc sp_playlistcontainer_release*(pc: ptr sp_playlistcontainer): sp_error {. cdecl, importc: "sp_playlistcontainer_release", dynlib: sf_dynlib .}
proc sp_playlistcontainer_get_unseen_tracks*(pc: ptr sp_playlistcontainer; 
    playlist: ptr sp_playlist; tracks: ptr ptr sp_track; num_tracks: cint): cint {. cdecl, importc: "sp_playlistcontainer_get_unseen_tracks", dynlib: sf_dynlib .}
proc sp_playlistcontainer_clear_unseen_tracks*(pc: ptr sp_playlistcontainer; 
    playlist: ptr sp_playlist): cint {. cdecl, importc: "sp_playlistcontainer_clear_unseen_tracks", dynlib: sf_dynlib .}
type 
  sp_relation_type* = enum 
    SP_RELATION_TYPE_UNKNOWN = 0, SP_RELATION_TYPE_NONE = 1, 
    SP_RELATION_TYPE_UNIDIRECTIONAL = 2, SP_RELATION_TYPE_BIDIRECTIONAL = 3


proc sp_user_canonical_name*(user: ptr sp_user): cstring {. cdecl, importc: "sp_user_canonical_name", dynlib: sf_dynlib .}
proc sp_user_display_name*(user: ptr sp_user): cstring {. cdecl, importc: "sp_user_display_name", dynlib: sf_dynlib .}
proc sp_user_is_loaded*(user: ptr sp_user): bool {. cdecl, importc: "sp_user_is_loaded", dynlib: sf_dynlib .}
proc sp_user_add_ref*(user: ptr sp_user): sp_error {. cdecl, importc: "sp_user_add_ref", dynlib: sf_dynlib .}
proc sp_user_release*(user: ptr sp_user): sp_error {. cdecl, importc: "sp_user_release", dynlib: sf_dynlib .}
type 
  sp_toplisttype* = enum 
    SP_TOPLIST_TYPE_ARTISTS = 0, SP_TOPLIST_TYPE_ALBUMS = 1, 
    SP_TOPLIST_TYPE_TRACKS = 2


template SP_TOPLIST_REGION*(a, b: expr): expr = 
  ((a) shl 8 or (b))

type 
  sp_toplistregion* = enum 
    SP_TOPLIST_REGION_EVERYWHERE = 0, SP_TOPLIST_REGION_USER = 1
  toplistbrowse_complete_cb* = proc (result: ptr sp_toplistbrowse; 
                                     userdata: pointer)


proc sp_toplistbrowse_create*(session: ptr sp_session; `type`: sp_toplisttype; 
                              region: sp_toplistregion; username: cstring; 
                              callback: ptr toplistbrowse_complete_cb; 
                              userdata: pointer): ptr sp_toplistbrowse {. cdecl, importc: "sp_toplistbrowse_create", dynlib: sf_dynlib .}
proc sp_toplistbrowse_is_loaded*(tlb: ptr sp_toplistbrowse): bool {. cdecl, importc: "sp_toplistbrowse_is_loaded", dynlib: sf_dynlib .}
proc sp_toplistbrowse_error*(tlb: ptr sp_toplistbrowse): sp_error {. cdecl, importc: "sp_toplistbrowse_error", dynlib: sf_dynlib .}
proc sp_toplistbrowse_add_ref*(tlb: ptr sp_toplistbrowse): sp_error {. cdecl, importc: "sp_toplistbrowse_add_ref", dynlib: sf_dynlib .}
proc sp_toplistbrowse_release*(tlb: ptr sp_toplistbrowse): sp_error {. cdecl, importc: "sp_toplistbrowse_release", dynlib: sf_dynlib .}
proc sp_toplistbrowse_num_artists*(tlb: ptr sp_toplistbrowse): cint {. cdecl, importc: "sp_toplistbrowse_num_artists", dynlib: sf_dynlib .}
proc sp_toplistbrowse_artist*(tlb: ptr sp_toplistbrowse; index: cint): ptr sp_artist {. cdecl, importc: "sp_toplistbrowse_artist", dynlib: sf_dynlib .}
proc sp_toplistbrowse_num_albums*(tlb: ptr sp_toplistbrowse): cint {. cdecl, importc: "sp_toplistbrowse_num_albums", dynlib: sf_dynlib .}
proc sp_toplistbrowse_album*(tlb: ptr sp_toplistbrowse; index: cint): ptr sp_album {. cdecl, importc: "sp_toplistbrowse_album", dynlib: sf_dynlib .}
proc sp_toplistbrowse_num_tracks*(tlb: ptr sp_toplistbrowse): cint {. cdecl, importc: "sp_toplistbrowse_num_tracks", dynlib: sf_dynlib .}
proc sp_toplistbrowse_track*(tlb: ptr sp_toplistbrowse; index: cint): ptr sp_track {. cdecl, importc: "sp_toplistbrowse_track", dynlib: sf_dynlib .}
proc sp_toplistbrowse_backend_request_duration*(tlb: ptr sp_toplistbrowse): cint {. cdecl, importc: "sp_toplistbrowse_backend_request_duration", dynlib: sf_dynlib .}
type 
  inboxpost_complete_cb* = proc (result: ptr sp_inbox; userdata: pointer)

proc sp_inbox_post_tracks*(session: ptr sp_session; user: cstring; 
                           tracks: ptr ptr sp_track; num_tracks: cint; 
                           message: cstring; 
                           callback: ptr inboxpost_complete_cb; 
                           userdata: pointer): ptr sp_inbox {. cdecl, importc: "sp_inbox_post_tracks", dynlib: sf_dynlib .}
proc sp_inbox_error*(inbox: ptr sp_inbox): sp_error {. cdecl, importc: "sp_inbox_error", dynlib: sf_dynlib .}
proc sp_inbox_add_ref*(inbox: ptr sp_inbox): sp_error {. cdecl, importc: "sp_inbox_add_ref", dynlib: sf_dynlib .}
proc sp_inbox_release*(inbox: ptr sp_inbox): sp_error {. cdecl, importc: "sp_inbox_release", dynlib: sf_dynlib .}
proc sp_build_id*(): cstring {. cdecl, importc: "sp_build_id", dynlib: sf_dynlib .}
