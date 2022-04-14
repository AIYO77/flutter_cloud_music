/* 首页推荐类型常量 --------- start ----------- */

///展示类型  每个类型对应一个weight组件
const SHOWTYPE_BALL = "BALL";
const SHOWTYPE_BANNER = "BANNER";
const SHOWTYPE_HOMEPAGE_SLIDE_PLAYLIST = "HOMEPAGE_SLIDE_PLAYLIST";
const SHOWTYPE_HOMEPAGE_NEW_SONG_NEW_ALBUM = "HOMEPAGE_NEW_SONG_NEW_ALBUM";
const SHOWTYPE_SLIDE_SINGLE_SONG = "SLIDE_SINGLE_SONG";
const SHOWTYPE_SHUFFLE_MUSIC_CALENDAR = "SHUFFLE_MUSIC_CALENDAR";
const SHOWTYPE_HOMEPAGE_SLIDE_SONGLIST_ALIGN = "HOMEPAGE_SLIDE_SONGLIST_ALIGN";
const SHOWTYPE_SHUFFLE_MLOG = "SHUFFLE_MLOG";
const SHOWTYPE_SLIDE_VOICELIST = "SLIDE_VOICELIST";
const HOMEPAGE_SLIDE_PLAYABLE_MLOG = 'HOMEPAGE_SLIDE_PLAYABLE_MLOG';
const SHOWTYPE_SLIDE_PLAYABLE_DRAGON_BALL = "SLIDE_PLAYABLE_DRAGON_BALL";
const SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB =
    "SLIDE_PLAYABLE_DRAGON_BALL_MORE_TAB";
const SLIDE_RCMDLIKE_VOICELIST = 'SLIDE_RCMDLIKE_VOICELIST'; //热门播客

/* 首页推荐类型常量 --------- end ----------- */

//app内部跳转标识
const APP_ROUTER_TAG = 'orpheus';

//官方歌单标识
const ALG_OP = 'ALG_OP';

/* HERO  --------- start -----------   */

const HERO_TAG_CUR_PLAY = 'currentPlay';

const SINGLE_SEARCH = 'single_search';

/* HERO  --------- end ----------- */

/* cache key  --------- start ----------- */

const CACHE_HOME_FOUND_DATA = 'home_fond_data';
const CACHE_FAVORITE_SONG_IDS = 'favoriteSongIds'; //喜欢的歌曲ID列表
const CACHE_FAVORITE_VIDEO_IDS = 'favoriteVideoIds'; //喜欢的视频ID列表
const CACHE_LOGIN_DATA = 'cache_login_data';
const CACHE_MUSIC_COMMENT_COUNT = 'cache_music_comment_count';
const CACHE_ALBUM_POLY_DETAIL_URL = 'cache_album_poly_detail_url'; //数字专辑Url
const CACHE_HISTORY_SEARCH = 'cache_history_search'; //历史搜索

/* cache key  --------- end ----------- */

/*search type --------- start ---------*/
const SEARCH_SONGS = 1; //单曲
const SEARCH_VIDEOS = 1014; //视频
const SEARCH_ALBUMS = 10; //专辑
const SEARCH_SINGER = 100; //歌手
const SEARCH_PLAYLIST = 1000; //歌单
const SEARCH_USER = 1002; //用户
const SEARCH_COMPOSITE = 1018; //综合
/*search type --------- end ---------*/

/* resource type  --------- start ----------- */
const RESOURCE_SONGS = 0; //歌曲
const RESOURCE_MV = 1; //MV
const RESOURCE_PL = 2; //歌单
const RESOURCE_AL = 3; //专辑
const RESOURCE_RADIO = 4; //电台
const RESOURCE_VIDEO = 5; //视频
const RESOURCE_EVENT = 6; //动态
const RESOURCE_MLOG = -1; //mlog
/* resource type  --------- end ----------- */
