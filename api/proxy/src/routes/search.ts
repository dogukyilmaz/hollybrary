import express from 'express';
import axios from 'axios';

axios.interceptors.request.use((config) => {
  config.headers = config.headers ?? {};
  config.headers['Access-Control-Allow-Origin'] = '*';
  config.headers['Accept-Encoding'] = 'gzip,deflate,compress';
  return config;
});

const router = express.Router();

router.get('/movie', (req, res, next) => {
  axios
    .get(
      `${process.env.TMDB_BASE_URL}/search/movie?api_key=${process.env.TMBD_API_KEY}&query=${req.query.text}&page=${req.query.page}&include_adult=true`
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
      `${process.env.TMDB_BASE_URL}/search/tv?api_key=${process.env.TMBD_API_KEY}&query=${req.query.text}&page=${req.query.page}&include_adult=true`
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
router.get('/cast', (req, res, next) => {
  axios
    .get(
      `${process.env.TMDB_BASE_URL}/search/person?api_key=${process.env.TMBD_API_KEY}&query=${req.query.text}&page=${req.query.page}&include_adult=true`
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
