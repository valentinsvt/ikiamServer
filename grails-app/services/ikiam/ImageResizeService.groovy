package ikiam

import grails.transaction.Transactional
import org.imgscalr.Scalr

import javax.imageio.ImageIO
import java.awt.AlphaComposite
import java.awt.Graphics2D
import java.awt.Polygon
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC

@Transactional
class ImageResizeService {

    def createMarker(String pathFile, String newPath) {
        resizeImage(pathFile, newPath, 35, true)
    }

    def resizeAndroid(String pathFile, String newPath) {
        resizeImage(pathFile, newPath, 700, false)
    }

    def resizeImage(String pathFile, String newPath, int maxW, boolean marker) {

        def file = new File(pathFile)
        if (file.exists()) {

            java.awt.Color color = new java.awt.Color(22, 180, 209)
            java.awt.Color transparent = new java.awt.Color(255, 255, 255, 255)

            BufferedImage img = ImageIO.read(file); // load image
            // Create quickly, then smooth and brighten it.
            BufferedImage thumbImg = Scalr.resize(img, Scalr.Method.BALANCED, maxW, Scalr.OP_ANTIALIAS, Scalr.OP_BRIGHTER);

            // Let's add a little border before we return result.
//        thumbImg = Scalr.pad(thumbImg, 2, new java.awt.Color(159, 207, 103));
            if (marker) {
                def w = thumbImg.getWidth();
                def h = thumbImg.getHeight();

                def pinW = 10;
                def pinH = 10;

                BufferedImage newThumb = new BufferedImage(w + 4, h + pinH, BufferedImage.TYPE_INT_ARGB)

                w = newThumb.getWidth()
//            h = newThumb.getHeight()

                def pinIniX = (int) ((w / 2) - (pinW / 2));
                def pinFinX = (int) ((w / 2) + (pinW / 2));
                def pinBaseY = h + 2;
                def pinX = (int) (w / 2);
                def pinY = h + pinH;

                int[] triangleX = [pinIniX, pinFinX, pinX]
                int[] triangleY = [pinBaseY, pinBaseY, pinY]
                Polygon p = new Polygon(triangleX, triangleY, 3);

                thumbImg = Scalr.pad(thumbImg, 2, color);
                Graphics2D g = newThumb.createGraphics();
                g.setComposite(AlphaComposite.Clear);
                g.setColor(transparent);
                g.fillRect(0, 0, w + 4, h + pinH);
                g.setComposite(AlphaComposite.Src);
                g.drawImage(thumbImg, 0, 0, null);
                g.setColor(color);
                g.fillPolygon(p);
                // Clean up -- dispose the graphics context that was created.
                g.dispose();

                thumbImg = newThumb
            }

            File outputfile = new File(newPath);
            ImageIO.write(thumbImg, "png", outputfile);
        }
    }

//    def resizeImage(String pathFile, String newPath, int maxW, int maxH) {
////            if (imageContent.containsKey(f.getContentType())) {
//        /* RESIZE */
//        def img = ImageIO.read(new File(pathFile))
//
//        def ext
//
//        def parts = pathFile.split("\\.")
//        parts.eachWithIndex { obj, i ->
//            if (i < parts.size() - 1) {
//
//            } else {
//                ext = obj
//            }
//        }
//
////        def scale = 0.5
////
////        def minW = 200
////        def minH = 200
////
////        def maxW = 50
////        def maxH = 50
//
//        def w = img.width
//        def h = img.height
//
//        if (w > maxW || h > maxH) {
//            int newW = w /* * scale*/
//            int newH = h /* * scale*/
//            int r
//            if (w > h) {
//                r = w / maxW
//                newW = maxW
//                newH = h / r
//            } else {
//                r = h / maxH
//                newH = maxH
//                newW = w / r
//            }
//
//            new BufferedImage(newW, newH, img.type).with { j ->
//                createGraphics().with {
//                    setRenderingHint(KEY_INTERPOLATION, VALUE_INTERPOLATION_BICUBIC)
//                    drawImage(img, 0, 0, newW, newH, null)
//                    dispose()
//                }
//                ImageIO.write(j, ext, new File(newPath))
//            }
//        }
//        /* fin resize */
////            } //si es imagen hace resize para que no exceda 800x800
//    }
}
