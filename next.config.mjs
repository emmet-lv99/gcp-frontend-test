import { createVanillaExtractPlugin } from "@vanilla-extract/next-plugin"

/** @type {import('next').NextConfig} */
const withVanillaExtract = createVanillaExtractPlugin()

const nextConfig = {
  /* config options here */
  reactCompiler: true,
  output: "standalone",
}

export default withVanillaExtract(nextConfig)
