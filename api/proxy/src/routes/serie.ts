import express from 'express';
import axios from 'axios';

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
      axios.get(`${process.env.TMDB_BASE_URL}/tv/${req.params.id}?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(`${process.env.TMDB_BASE_URL}/tv/${req.params.id}/videos?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(
        `${process.env.TMDB_BASE_URL}/tv/${req.params.id}/images?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
      axios.get(
        `${process.env.TMDB_BASE_URL}/tv/${req.params.id}/credits?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
      axios.get(
        `${process.env.TMDB_BASE_URL}/tv/${req.params.id}/similar?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
    ])
    .then(
      axios.spread((data, videos, images, credits, similar) => {
        res.status(200).json({
          success: true,
          data: data.data,
          videos: videos.data,
          images: images.data,
          credits: credits.data,
          similar: similar.data,
        });
      })
    )
    .catch((err) => next(err));
});

export default router;
