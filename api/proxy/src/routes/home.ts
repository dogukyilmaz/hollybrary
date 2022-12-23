import express from 'express';
import tmdbHttp from 'service/tmdbHttp';
import dotenv from 'dotenv';
import { cloneHomeData } from 'controller/pocketbase';

dotenv.config();

const router = express.Router();

router.get('/', async (req, res, next) => {
  try {
    const [trendingMovies, nowPlayingMovies, upcomingMovies, topRatedMovies, trendingSeries, topRatedSeries] = await Promise.all([
      tmdbHttp.get(`/trending/movie/day?api_key=${process.env.TMBD_API_KEY}`),
      tmdbHttp.get(`/movie/now_playing?api_key=${process.env.TMBD_API_KEY}`),
      tmdbHttp.get(`/movie/upcoming?api_key=${process.env.TMBD_API_KEY}`),
      tmdbHttp.get(`/movie/top_rated?api_key=${process.env.TMBD_API_KEY}&page=1)}`),
      tmdbHttp.get(`/trending/tv/day?api_key=${process.env.TMBD_API_KEY}`),
      tmdbHttp.get(`/tv/top_rated?api_key=${process.env.TMBD_API_KEY}&page=1`),
    ]);

    await cloneHomeData('trending_movies', trendingMovies?.data?.results || []);

    res.status(200).json({
      success: true,
      message: 'Ok',
      data: {
        trendingMovies: trendingMovies?.data?.results || [],
        nowPlayingMovies: nowPlayingMovies?.data?.results || [],
        upcomingMovies: upcomingMovies?.data?.results || [],
        topRatedMovies: topRatedMovies?.data?.results || [],
        trendingSeries: trendingSeries?.data?.results || [],
        topRatedSeries: topRatedSeries?.data?.results || [],
      },
    });
  } catch (error) {
    console.log(error, 'error');
    next(error);
  }
});

export default router;
