import type { ErrorRequestHandler } from 'express';

export const errorHandler: ErrorRequestHandler = (err, req, res, next) => {
  res.status(err.response || 500).json({
    success: false,
    status: err.status,
    message: err.message,
    results: err,
  });
};
