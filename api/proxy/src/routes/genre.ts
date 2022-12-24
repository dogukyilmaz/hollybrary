import express from 'express';
import axios from 'axios';

const router = express.Router();

router.get('/movie', (req, res, next) => {
  axios
    .get(
      `${process.env.TMDB_BASE_URL}/discover/movie?api_key=${process.env.TMBD_API_KEY}&include_adult=true&language=en-US&sort_by=popularity.desc&with_genres=${req.query.id}&page=${req.query.page}`
    )
    .then((data) => {
      res.status(200).json({
        success: true,
        data: data.data.results,
        total_pages: data.data.total_pages,
        total_results: data.data.total_results,
      });
    })
    .catch((err) => next(err));
});

router.get('/serie', (req, res, next) => {
  axios
    .get(
      `${process.env.TMDB_BASE_URL}/discover/tv?api_key=${process.env.TMBD_API_KEY}&include_adult=true&language=en-US&sort_by=popularity.desc&with_genres=${req.query.id}&page=${req.query.page}`
    )
    .then((data) => {
      res.status(200).json({
        success: true,
        data: data.data.results,
        total_pages: data.data.total_pages,
        total_results: data.data.total_results,
      });
    })
    .catch((err) => next(err));
});

export default router;
