export default class ImageUtil {

    static images = {
    };

    static getImage(imageUrl) {
        if (imageUrl && imageUrl.indexOf('http') > -1) {
            const fileName = imageUrl.substring(imageUrl.lastIndexOf('/') + 1, imageUrl.length);
            const fileNameWithoutExtension = fileName.substring(0, fileName.lastIndexOf('.'));
            if (fileNameWithoutExtension && this.images[fileNameWithoutExtension]) {
                return this.images[fileNameWithoutExtension];
            } else {
                return {uri: imageUrl};
            }
        } else if (imageUrl && imageUrl.indexOf('base64') > -1) {
            return {uri: imageUrl};
        } else {
            if (this.images[imageUrl]) {
                return this.images[imageUrl];
            } else {
                return '../../public/images/ic-loading.gif';
            }
        }
    }
}
