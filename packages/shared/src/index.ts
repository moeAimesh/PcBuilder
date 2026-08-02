import { z } from "zod";

/**
 * Shared domain types. Grow these in Phase 2 —
 * every entity gets a Zod schema here; the API, ETL,
 * and frontend all import the inferred types.
 */

export const RegionCode = z.enum(["DE", "US"]);
export type RegionCode = z.infer<typeof RegionCode>;

export const IssueSeverity = z.enum(["blocker", "warning", "info"]);
export type IssueSeverity = z.infer<typeof IssueSeverity>;

export const CompatibilityIssue = z.object({
  ruleId: z.string(),
  severity: IssueSeverity,
  message: z.string(),
  affectedParts: z.array(z.string()),
  evidence: z.record(z.unknown()).optional(),
});
export type CompatibilityIssue = z.infer<typeof CompatibilityIssue>;
