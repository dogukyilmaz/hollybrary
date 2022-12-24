import axios from 'axios';
import express from 'express';

const router = express.Router();

router.get('/:id/season/:snum', (req, res, next) => {
  axios
    .all([
      axios.get(`${process.env.TMDB_BASE_URL}/tv/${req.params.id}/season/${req.params.snum}?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(`${process.env.TMDB_BASE_URL}/tv/${req.params.id}/season/${req.params.snum}/videos?api_key=${process.env.TMBD_API_KEY}`),
      axios.get(
        `${process.env.TMDB_BASE_URL}/tv/${req.params.id}/season/${req.params.snum}/images?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
      axios.get(
        `${process.env.TMDB_BASE_URL}/tv/${req.params.id}/season/${req.params.snum}/credits?api_key=${process.env.TMBD_API_KEY}&language=en-US&include_image_language=en`
      ),
    ])
    .then(
      axios.spread((data, videos, images, credits) => {
        res.status(200).json({
          success: true,
          data: data.data,
          videos: videos.data,
          images: images.data,
          credits: credits.data,
        });
      })
    )
    .catch((err) => next(err));
});
export default router;
