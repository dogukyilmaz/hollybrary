import express from 'express';
import axios from 'axios';
import { cloneHomeRecords } from '../controller/pocketbase';

const router = express.Router();

router.get('/', (req, res, next) => {
  axios
    .all([
      axios.get(`${process.env.TMDB_BASE_URL}/trending/movie/day?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(`${process.env.TMDB_BASE_URL}/movie/now_playing?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(`${process.env.TMDB_BASE_URL}/movie/top_rated?api_key=${process.env.TMBD_API_KEY}&page=1`),
      axios.get(`${process.env.TMDB_BASE_URL}/trending/tv/day?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(`${process.env.TMDB_BASE_URL}/tv/top_rated?api_key=${process.env.TMBD_API_KEY}&page=1`),
      axios.get(`${process.env.TMDB_BASE_URL}/movie/upcoming?api_key=${process.env.TMBD_API_KEY}`),
    ])
    .then(
      axios.spread(async (trendm, nowPlaying, top_rated, trandtv, topRatedTv, upcoming) => {
        // to save the data in the database (pocketbase)
        // await Promise.all([
        //   cloneHomeRecords('trending_movies', trendingMovies?.data?.results || []),
        //   cloneHomeRecords('now_playing_movies', nowPlayingMovies?.data?.results || []),
        //   cloneHomeRecords('upcoming_movies', upcomingMovies?.data?.results || []),
        //   cloneHomeRecords('top_rated_movies', topRatedMovies?.data?.results || []),
        //   cloneHomeRecords('trending_series', trendingSeries?.data?.results || []),
        //   cloneHomeRecords('top_rated_series', topRatedSeries?.data?.results || []),
        // ]);

        res.status(200).json({
          success: true,
          trandingMovies: trendm.data.results,
          nowPlayingMovies: nowPlaying.data.results,
          topRatedMovies: top_rated.data.results,
          trandingtv: trandtv.data.results,
          topRatedTv: topRatedTv.data.results,
          upcoming: upcoming.data.results,
        });
      })
    )
    .catch((err) => next(err));
});

export default router;
