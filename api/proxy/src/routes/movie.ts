import axios from 'axios';
import express from 'express';

const router = express.Router();

router.get('/:id', (req, res, next) => {
  axios
    .all([
      axios.get(`${process.env.TMDB_BASE_URL}/movie/${req.params.id}?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(`${process.env.TMDB_BASE_URL}/movie/${req.params.id}/videos?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(
        `${process.env.TMDB_BASE_URL}/movie/${req.params.id}/images?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
      axios.get(
        `${process.env.TMDB_BASE_URL}/movie/${req.params.id}/credits?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
      axios.get(
        `${process.env.TMDB_BASE_URL}/movie/${req.params.id}/similar?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
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

router.get('/omdb/:id', (req, res, next) => {
  console.log(`${process.env.OMDB_BASE_URL}/?apikey=${process.env.OMDB_API_KEY}&i=${req.params.id}`, 'api');
  axios
    .get(`${process.env.OMDB_BASE_URL}/?apikey=${process.env.OMDB_API_KEY}&i=${req.params.id}`)
    .then((data) => {
      res.status(200).json({
        success: true,
        data: data.data,
      });
    })
    .catch((err) => next(err));
});

export default router;

// http://www.omdbapi.com/?i=$id&apikey=
