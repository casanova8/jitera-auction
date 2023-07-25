import type { ApiRoutes } from '@vse-bude/shared';
import { Router } from 'express';
import type { Request } from 'express';
import { wrap } from '@helpers';
import type { Services } from '@services';
import { apiPath } from '@helpers';
import { authMiddleware } from '@middlewares';
import multer from 'multer';
import type { CreateOtherDto } from '@types';

export const initOtherRoutes = (
  { otherService,productService }: Services,
  path: ApiRoutes,
): Router => {
  const router = Router();

  /**
   * @openapi
   * /categories:
   *   get:
   *     tags: [Category]
   *     produces:
   *       - application/json
   *     parameters:
   *       - in: header
   *         name: accept-language
   *         schema:
   *            type: string
   *            enum: [en, ua]
   *     responses:
   *       200:
   *         description: Ok
   *         content:
   *           application/json:
   *             schema:
   *               type: object
   *               $ref: "#/definitions/GetCategoriesResponse"
   *       4**:
   *         description: Something went wrong
   *         content:
   *           application/json:
   *             schema:
   *               $ref: "#/definitions/Response400"
   */

  router.get(
    path,
    authMiddleware,
    wrap(() => otherService.getAll()),
  );
  router.post(
    apiPath(path),
    authMiddleware,
    multer().any(),
    wrap((req: Request) =>
      otherService.createProduct({
        req,
        userId: req.userId,
        fieldsData: req.body,
      }),
    ),
  );
  return router;
};
