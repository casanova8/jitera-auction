import type { PrismaClient,Product } from '@prisma/client';
import { ProductStatus } from '@prisma/client';
import type { OtherResponseDto } from '@vse-bude/shared';

export class OtherRepository {
  private _dbClient: PrismaClient;

  constructor(prismaClient: PrismaClient) {
    this._dbClient = prismaClient;
  }

  public getAll(): Promise<OtherResponseDto[]> {
    console.log('Others')
    return this._dbClient.$queryRaw`
      SELECT
        "Category"."id",
        "Category"."title",
        "Category"."image",
        "Category"."createdAt",
        "Category"."updatedAt",
        CAST (
          SUM (
            CASE "Product"."status" 
              WHEN CAST(${ProductStatus.ACTIVE} AS "ProductStatus")
              THEN 1
              ELSE 0
            END ) AS INTEGER) AS "productsCount"
      FROM
        "Category"
      LEFT JOIN
        "Product"
      ON
        "Product"."categoryId" = "Category"."id"     
      GROUP BY
        "Category"."id",
        "Category"."title",
        "Category"."image",
        "Category"."createdAt",
        "Category"."updatedAt"
      `;
  }
  public create(data): Promise<Product> {
    console.log('others insert')
    return this._dbClient.product.create({
      data: {
        imageLinks: data.imageLinks,
        country: data.country,
        city: data.city,
        phone: data.phone,
        status: data.status,
        categoryId: data.category,
        title: data.title,
        description: data.description,
        authorId: data.authorId,
        type: data.type,
        price: data.price,
        minimalBid: data.minimalBid,
        recommendedPrice: data.recommendedPrice,
        endDate: data.endDate,
        postDate: data.postDate,
      },
    });
  }
}
