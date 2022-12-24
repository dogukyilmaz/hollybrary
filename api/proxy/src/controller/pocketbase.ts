import { NextFunction } from 'express';
import PocketBase from 'pocketbase';
const client = new PocketBase('http://0.0.0.0:8090');

// import {} from 'eventsource'

// const g = global as any;
// g.EventSource = require('eventsource');

export type HomeCollectionOption =
  | 'trending_movies'
  | 'now_playing_movies'
  | 'upcoming_movies'
  | 'top_rated_movies'
  | 'trending_series'
  | 'top_rated_series';

export type HomeCollectionType = {
  id?: number;
  _id?: number;
  adult: boolean;
  backdrop_path: string;
  original_language: string;
  overview: string;
  poster_path: string;
  media_type: string;
  genre_ids: number[];
  popularity: number;
  vote_average: number;
  vote_count: number;
  title?: string;
  original_title?: string;
  release_date?: string;
  video?: boolean;
  original_name?: string; // original_title
  name?: string; // title
  first_air_date?: '2020-12-10'; // release_date
  origin_country?: string[];
};

export const cloneHomeRecords = (type: HomeCollectionOption, records: HomeCollectionType[]) => {
  try {
    const promises = records.map((record) => {
      const {
        id,
        title,
        name,
        original_title,
        original_name,
        release_date,
        first_air_date,
        poster_path,
        backdrop_path,
        video,
        origin_country,
        ...rest
      } = record;
      return client.collection(type).create<HomeCollectionType>(
        {
          _id: id,
          title: title || name || '',
          original_title: original_title || original_name || '',
          release_date: release_date || first_air_date || '',
          video: video || false,
          poster_path: `https://image.tmdb.org/t/p/w500/${poster_path}`,
          backdrop_path: `https://image.tmdb.org/t/p/w500/${backdrop_path}`,
          ...rest,
        },
        {
          $autoCancel: false,
        }
      );
    });

    return Promise.all(promises);
  } catch (error) {
    console.log(error, 'error in cloneHomeData');
    return error;
  }
};

export const cloneHomeData = async (type: HomeCollectionOption, data: HomeCollectionType[], next: NextFunction) => {
  console.log('cloneHomeData', type);

  const { id, poster_path, backdrop_path, ...rest } = data[0];

  try {
  } catch (error) {
    console.log(error, 'error in cloneHomeData');
  }
};
