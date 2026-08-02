-- CreateEnum
CREATE TYPE "Region" AS ENUM ('DE', 'US');

-- CreateTable
CREATE TABLE "Motherboard" (
    "id" TEXT NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "socket" TEXT NOT NULL,
    "chipset" TEXT NOT NULL,
    "formFactor" TEXT NOT NULL,
    "memoryType" TEXT NOT NULL,
    "m2Slots" JSONB NOT NULL,
    "pcieSlots" JSONB NOT NULL,
    "dimensions" JSONB,
    "specSource" TEXT NOT NULL,
    "specDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Motherboard_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Cpu" (
    "id" TEXT NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "socket" TEXT NOT NULL,
    "tdpW" INTEGER NOT NULL,
    "peakPowerW" INTEGER NOT NULL,
    "specSource" TEXT NOT NULL,
    "specDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Cpu_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "BiosSupport" (
    "motherboardId" TEXT NOT NULL,
    "cpuId" TEXT NOT NULL,
    "minBiosVer" TEXT NOT NULL,

    CONSTRAINT "BiosSupport_pkey" PRIMARY KEY ("motherboardId","cpuId")
);

-- CreateTable
CREATE TABLE "GpuChip" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "tbpW" INTEGER NOT NULL,
    "pcieGen" INTEGER NOT NULL,
    "perfTier" JSONB,

    CONSTRAINT "GpuChip_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "GpuVariant" (
    "id" TEXT NOT NULL,
    "chipId" TEXT NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "lengthMm" INTEGER NOT NULL,
    "heightMm" INTEGER,
    "slotThickness" DOUBLE PRECISION NOT NULL,
    "powerConnectors" TEXT NOT NULL,
    "ean" TEXT,
    "specSource" TEXT NOT NULL,
    "specDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "GpuVariant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Case" (
    "id" TEXT NOT NULL,
    "brand" TEXT NOT NULL,
    "model" TEXT NOT NULL,
    "formFactors" JSONB NOT NULL,
    "gpuMaxLengthMm" INTEGER NOT NULL,
    "coolerMaxHeightMm" INTEGER NOT NULL,
    "radiatorSupport" JSONB NOT NULL,
    "psuMaxLengthMm" INTEGER,
    "specSource" TEXT NOT NULL,
    "specDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Case_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Retailer" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "region" "Region" NOT NULL,
    "affiliateTag" TEXT,

    CONSTRAINT "Retailer_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PriceSnapshot" (
    "id" TEXT NOT NULL,
    "gpuVariantId" TEXT NOT NULL,
    "retailerId" TEXT NOT NULL,
    "region" "Region" NOT NULL,
    "currency" TEXT NOT NULL,
    "priceCents" INTEGER NOT NULL,
    "inStock" BOOLEAN NOT NULL,
    "capturedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "PriceSnapshot_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Motherboard_brand_model_key" ON "Motherboard"("brand", "model");

-- CreateIndex
CREATE UNIQUE INDEX "Cpu_brand_model_key" ON "Cpu"("brand", "model");

-- CreateIndex
CREATE UNIQUE INDEX "GpuChip_name_key" ON "GpuChip"("name");

-- CreateIndex
CREATE UNIQUE INDEX "GpuVariant_ean_key" ON "GpuVariant"("ean");

-- CreateIndex
CREATE UNIQUE INDEX "GpuVariant_brand_model_key" ON "GpuVariant"("brand", "model");

-- CreateIndex
CREATE UNIQUE INDEX "Case_brand_model_key" ON "Case"("brand", "model");

-- CreateIndex
CREATE UNIQUE INDEX "Retailer_name_key" ON "Retailer"("name");

-- CreateIndex
CREATE INDEX "PriceSnapshot_gpuVariantId_region_capturedAt_idx" ON "PriceSnapshot"("gpuVariantId", "region", "capturedAt");

-- AddForeignKey
ALTER TABLE "BiosSupport" ADD CONSTRAINT "BiosSupport_motherboardId_fkey" FOREIGN KEY ("motherboardId") REFERENCES "Motherboard"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "BiosSupport" ADD CONSTRAINT "BiosSupport_cpuId_fkey" FOREIGN KEY ("cpuId") REFERENCES "Cpu"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "GpuVariant" ADD CONSTRAINT "GpuVariant_chipId_fkey" FOREIGN KEY ("chipId") REFERENCES "GpuChip"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceSnapshot" ADD CONSTRAINT "PriceSnapshot_gpuVariantId_fkey" FOREIGN KEY ("gpuVariantId") REFERENCES "GpuVariant"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PriceSnapshot" ADD CONSTRAINT "PriceSnapshot_retailerId_fkey" FOREIGN KEY ("retailerId") REFERENCES "Retailer"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
