import axios from 'axios';
import express from 'express';

axios.interceptors.request.use((config) => {
  config.headers = config.headers ?? {};
  config.headers['Access-Control-Allow-Origin'] = '*';
  config.headers['Accept-Encoding'] = 'gzip,deflate,compress';
  return config;
});

const router = express.Router();

router.get('/:id', (req, res, next) => {
  axios
    .all([
      axios.get(`${process.env.TMDB_BASE_URL}/person/${req.params.id}?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(`${process.env.TMDB_BASE_URL}/person/${req.params.id}/external_ids?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(
        `${process.env.TMDB_BASE_URL}/person/${req.params.id}/images?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
      axios.get(
        `${process.env.TMDB_BASE_URL}/person/${req.params.id}/tv_credits?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
      axios.get(
        `${process.env.TMDB_BASE_URL}/person/${req.params.id}/movie_credits?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
    ])
    .then(
      axios.spread((data, social, images, credits, similar) => {
        res.status(200).json({
          success: true,
          data: data.data,
          socialmedia: social.data,
          images: images.data,
          tv: credits.data,
          movies: similar.data,
        });
      })
    )
    .catch((err) => next(err));
});
export default router;
