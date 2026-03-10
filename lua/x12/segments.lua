-- lua/x12/segments.lua
-- Segment metadata, element parsing, and resolution for X12 EDI (837/835/277).
-- Extracted from ftplugin/x12.lua so this logic can be reused in statuslines,
-- Telescope pickers, commands, or tests without duplicating code.

local M = {}

-- =============================
-- Segment / qualifier lookup table
-- =============================
M.segments = {
    -- Generic segments
    -- ["AMT"]     = "Dollar Amount",
    ["AMT.D"] = "Discount Amount",
    ["AMT.EAF"] = "Patient Paid Amount",
    ["CAS"] = "Adjustment amount",
    -- ["HL"]   = "Hierarchical Level",
    ["SVC"] = "Service Line",
    ["BPR"] = "Payment Information",
    ["TRN"] = "Trace Number",
    ["N1.PE"] = "Payer Name",
    ["N1.PR"] = "Payee / Provider",
    ["N1.ZZ"] = "Additional Entity",
    ["N1"] = "Name Segment",
    -- ["N3"]   = "Address",
    -- ["N4"]   = "City/State/ZIP",
    ["REF.2U"] = "Payer ID",
    ["REF.EV"] = "Payer Claim Number",
    ["REF.F2"] = "Provider Tax ID",
    ["DTM"] = "Date/Time Reference",
    ["ADX"] = "Adjustment Information",
    ["AD1"] = "Adjustment Detail 1",
    ["AD2"] = "Adjustment Detail 2",
    ["PLB"] = "Provider Level Balances",
    ["DMG"] = "Demographic information (DOB and sex)",
    ["HI"] = "Diagnosis Codes",
    -- COB levels
    ["SBR.P"] = "Primary claim",
    ["SBR.S"] = "Secondary claim",
    ["SBR.T"] = "Tertiary claim",
    -- NM1 qualifiers
    ["NM1.77"] = "Facility",
    ["NM1.82"] = "Rendering Provider",
    ["NM1.85"] = "Billing Provider",
    ["NM1.87"] = "Pay-to Provider",
    ["NM1.IL"] = "Subscriber",
    ["NM1.QC"] = "Patient",
    ["NM1.PR"] = "Payer",
    ["NM1.DN"] = "Referring Provider",
    ["NM1.P3"] = "Primary Care Provider",
    ["PRV"] = "Taxonomy code",
    -- ["NM1"] = "Name Information",
    -- Dates
    ["DTP.472"] = "Service Date",
    ["DTP.434"] = "Statement Dates",
    ["DTP.050"] = "Received Date",
    ["DTP.009"] = "Processed Date",
    ["DTP.573"] = "Adjudication Date",
    ["DTP.435"] = "Admission Date",
    ["DTP.096"] = "Discharge Date",
    ["DTP.431"] = "Onset of Illness or Symptom",
    ["DTP.360"] = "Initial Treatment Date",
    ["DTP.304"] = "Last Seen Date",
    ["DTM*405"] = "Payment issue/release date",
    ["BPR16"] = "Payment effective date",
    -- REF qualifiers
    ["REF.1K"] = "Payer Claim ID",
    ["REF.6R"] = "Provider Control Number",
    ["REF.EI"] = "Tax ID",
    ["REF.D9"] = "Claim Number",
    ["REF.F8"] = "Original Reference Number",
    -- ["REF"] = "Reference",
    -- STC / 835 status codes
    ["STC.A0"] = "Received / Informational Only",
    ["STC.A1"] = "Accepted for Adjudication / Paid",
    ["STC.A2"] = "Rejected / Denied",
    ["STC.A3"] = "Returned; Correction Required",
    ["STC.A6"] = "Acknowledgment Error",
    ["STC.A7"] = "Response Error",
}

-- =============================
-- Split elements while preserving empty fields
-- =============================
---@param line string  Raw buffer line
---@return table|nil   Array of element strings, [1] = segment ID (uppercased)
function M.get_elements(line)
    local seg, sep = line:match("^%s*([A-Za-z0-9]+)([*|])")
    if not seg then
        return nil
    end

    local elements = {}
    local pattern = "(.-)" .. sep
    local last_end = 1
    for element, pos in line:gmatch(pattern .. "()") do
        table.insert(elements, element)
        last_end = pos
    end
    table.insert(elements, line:sub(last_end))
    elements[1] = elements[1]:upper() -- normalize segment ID
    return elements
end

-- =============================
-- Resolve segment / qualifier / STC to a human-readable label
-- =============================
---@param elements table   Output of get_elements()
---@param line     string  Original raw line (used for STC loop detection)
---@return string|nil
function M.resolve_segment(elements, line)
    local seg = elements[1]
    local qualifier = elements[2]

    -- STC: show status code label + loop-level context
    if seg == "STC" and qualifier then
        local code = qualifier:match("(%w+):?%d*")
        local key = "STC." .. code
        if M.segments[key] then
            local loop = line:match("[*|]2000E") and "Claim level"
                or line:match("[*|]2000D") and "Subscriber level"
                or line:match("[*|]2000C") and "Provider level"
                or "Envelope level"
            return M.segments[key] .. " (" .. loop .. ")"
        end
    end

    -- Segment + qualifier (e.g. NM1.82, REF.1K)
    if qualifier then
        local key = seg .. "." .. qualifier
        if M.segments[key] then
            return M.segments[key]
        end
    end

    -- Fallback to generic segment label
    return M.segments[seg]
end

return M
