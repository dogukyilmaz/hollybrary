import axios from 'axios';
import express from 'express';
import PocketBase from 'pocketbase';

const router = express.Router();

const pb = new PocketBase('http://0.0.0.0:8090');

router.post('/create-list', async (req, res, next) => {
  console.log(req.body, 'req.query');

  try {
    const authRes = await pb.admins.authWithPassword('admin@hollybrary.com', '1234567890');
    if (!pb.authStore.isValid) return res.json({ success: false, message: 'Invalid credentials' });
    console.log(req.body.name, 'req.body.name');
    const resp = await axios.post(
      'http://0.0.0.0:8090/api/collections',
      {
        name: req.body.name,
        type: 'base',
        schema: [
          {
            name: 'title',
            type: 'text',
            required: true,
            options: {
              min: 10,
            },
          },
          {
            name: 'status',
            type: 'bool',
          },
        ],
      },
      { headers: { Authorization: pb.authStore.token } }
    );

    // const collection = await pb.collections.create(
    //   {
    //     name: req.body.name,
    //     type: 'base',
    //     schema: [
    //       {
    //         name: 'title',
    //         type: 'text',
    //         required: true,
    //         options: {
    //           min: 10,
    //         },
    //       },
    //       {
    //         name: 'status',
    //         type: 'bool',
    //       },
    //     ],
    //   },
    //   {}
    // );
    // console.log(collection, 'collection');
    // res.json({ success: true, message: 'Ok', data: collection });
    res.json({ success: true, message: 'Ok', data: resp });
  } catch (error) {
    res.json({ success: true, message: 'Ok', data: { error, token: pb.authStore.token } });
    // return error;
  }

  console.log(pb.authStore.isValid);
  console.log(pb.authStore.token);
  // console.log(pb.authStore.model.id);
  // try {

  // } catch (error) {
  //   console.log(error, 'error');
  //   next(error);
  // }
});

export default router;
