# Photos

Drop files in here with these exact names and they appear on the site. No code
change needed — every slot is a CSS background in `styles.css`, layered over a
warm gradient. Until a file exists the gradient shows on its own, so a missing
photo looks intentional rather than broken.

| File | Where it lands | Wants |
|---|---|---|
| `hero.jpg` | Homepage hero background, behind the headline | Wide, 2000px+, not busy in the upper left where the text sits. Interior wide shot is ideal. |
| `salon-1.jpg` | Homepage "Everyone in the family" portrait slot + first strip tile | Vertical or square. The room, chairs, the front of house. |
| `salon-2.jpg` | Strip tile 2 | A styling station, mirrors, product shelf. |
| `salon-3.jpg` | Strip tile 3 | Finished work — a cut or color, with the client's OK. |
| `salon-4.jpg` | Strip tile 4 | The storefront on N Central, or the sign. |

## Before adding any photo

- **Get the owner's OK.** These are the salon's images and, if anyone is
  recognizable, their clients' faces. Written permission for the client shots.
- **Strip EXIF.** Phone photos carry GPS. Same rule as the tv-ops job photos.
  ```bash
  exiftool -all= photos/*.jpg
  ```
- **Resize.** Nothing over ~2400px wide or ~400KB. These load on phones.
  ```bash
  sips -Z 2400 photos/*.jpg
  ```

## Why they are not already here

The photos on the Facebook page and Google profile could not be pulled
programmatically — both serve signed CDN URLs. They would also be the salon's
to give, not ours to take. Originals from the owner will look better than
anything scraped off a listing anyway.
