// const _url = "http://10.0.2.2";
const _url = "http://192.168.1.66";
const baseUrl = "$_url:8000";

const accountsUrl = "$baseUrl/accounts";

const loginUrl = "$accountsUrl/login/";
const registerUrl = "$accountsUrl/register/";
const profileUrl = "$accountsUrl/profile/";
const logoutUrl = "$accountsUrl/logout/";
const changePasswordUrl = "$accountsUrl/change-password/";

const moviesUrl = "$baseUrl/movies-api";

const movieListUrl = "$moviesUrl/movies/";
const upcomingMoviesUrl = "$moviesUrl/upcoming-movies/";
const recommendedMoviesUrl = "$moviesUrl/recommended-movies";

const theatersUrl = "$baseUrl/theaters-api";
const theaterListUrl = "$theatersUrl/theaters/";
const theaterReviewUrl = "${theaterListUrl}reviews";
const theaterReviewDetailUrl = "${theaterListUrl}reviews-detail/";

const showsUrl = "$baseUrl/shows-api";
const showsListUrl = "$showsUrl/shows";
const theaterSeatsUrl = "$showsUrl/seats";
const reservedSeatsUrl = "$showsUrl/reserved-seats/";

const ticketUrl = "$showsUrl/tickets/";

const bookedTicketUrl = "$showsUrl/transections/";
