# Variant Company Reference

## Norway — URL: www.variant.no | Greeting: "Vennlig hilsen,"

| Company name       | address_line1         | address_line2    |
|--------------------|-----------------------|------------------|
| Variant            | Kongens gate 36       | 7012 Trondheim   |
| Variant Trondheim  | Kongens gate 36       | 7012 Trondheim   |
| Variant Oslo       | Tollbugata 24         | 0157 Oslo        |
| Variant Bergen     | Vaskerelven 39        | 5014 Bergen      |
| Variant Stavanger  | Domkirkeplassen 2     | 4006 Stavanger   |

## Sweden — URL: www.variant.se | Greeting: "Med vänliga hälsningar,"

| Company name        | address_line1        | address_line2          |
|---------------------|----------------------|------------------------|
| Variant             | Barnhusgatan 20      | 111 23 Stockholm       |
| Variant Stockholm   | Barnhusgatan 20      | 111 23 Stockholm       |
| Variant Linköping   | Kungsgatan 41 b      | 582 18 Linköping       |
| Variant Göteborg    | Götgatan 15          | 411 05 Göteborg        |

## Phone number formatting

**Norwegian numbers (+47):** Format as `(+47) XX XX XX XX`
- Example: 97981877 → `(+47) 97 98 18 77`

**Swedish numbers (+46):** Format as `(+46) XX-XXX XX XX` for mobile, `(+46) X-XXX XXX XX` for landline
- Example: 0701234567 → `(+46) 70-123 45 67`
- If the user gives a number starting with 07x, treat as mobile. If starting with 08, treat as Stockholm landline.
- Strip leading 0 before adding country code.

## Greeting fallback

- Norwegian companies → `Vennlig hilsen,`
- Swedish companies → `Med vänliga hälsningar,`
- If the user expresses preference for English → `Best regards,`
