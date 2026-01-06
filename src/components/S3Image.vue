<template>
  <img :src="imageUrl" alt="S3 Image" />
</template>

<script>
import { S3Client, GetObjectCommand } from "@aws-sdk/client-s3";

export default {
  data() {
    return {
      imageUrl: "",
    };
  },
  async mounted() {
    const s3Client = new S3Client({
      region: "ap-northeast-1", // バケットのリージョン
      credentials: {
        accessKeyId: "YOUR_ACCESS_KEY", // 環境変数推奨
        secretAccessKey: "YOUR_SECRET_KEY",
      },
    });

    const command = new GetObjectCommand({
      Bucket: "your-bucket-name",
      Key: "image.jpg",
    });

    try {
      const response = await s3Client.send(command);
      // 画像URLを生成（署名付きURLが必要な場合）
      this.imageUrl = `https://your-bucket-name.s3.amazonaws.com/image.jpg`;
    } catch (error) {
      console.error("S3画像取得エラー:", error);
    }
  },
};
</script>
