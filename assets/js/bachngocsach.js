// ==MiruExtension==
// @name         3hentai
// @version      v0.0.1
// @author       ijs77
// @lang         all
// @license      MIT
// @icon         https://3hentai.net/favicon.ico
// @package      3hentai.net
// @type         manga
// @webSite      https://3hentai.net
// @nsfw         true
// ==/MiruExtension==


class BNSachExtension {
    constructor() {
        this.host = "https://bnsach.com";
    }

    async search(key, page) {
        if (!page) page = '0';
        let response = fetch(this.host + "/reader/search?ten=" + key + "&page=" + page);
        if (response.ok) {
            let doc = response.html();
            if (doc.select("title").text().includes("Đăng nhập để đọc truyện")) {
                return Response.error("Bạn cần đăng nhập hoặc tạo tài khoản mới để tiếp tục đọc truyện.");
            }
            let next = doc.select(".pager-next").last().select("a").attr("href").match(/page=(\d+)/);
            if (next) next = next[1];

            let novelList = [];
            doc.select("div.view-content li.search-row").forEach(e => novelList.push({
                name: e.select("div.search-truyen a").text(),
                link: e.select("div.search-truyen a").attr("href"),
                cover: e.select("div.search-anhbia img").attr("src"),
                description: e.select("div.search-tacgia a").text(),
                host: this.host
            }));

            return Response.success(novelList, next);
        }
        return null;
    }

    async tab(url, page) {
        if (!page) page = '0';
        let response = fetch(url + "/?page=" + page);
        if (response.ok) {
         let doc = response.html();

         let next = doc.select(".pager-next").last().select("a").attr("href").match(/page=(\d+)/);
         if (next) next = next[1];

         let novelList = [];
         doc.select(".view-content .term-row").forEach(e => {
             novelList.push({
                 name: e.select("a.term-truyen-a").text(),
                 link: e.select("a.term-truyen-a").attr("href"),
                 cover: e.select(".term-anhbia-a > img").attr("src"),
                 description: e.select(".term-tacgia").text(),
                 host: BASE_URL
             });
         });

         return Response.success(novelList, next);
        }
        return null;
    }

    async home() {
        return Response.success([
            {title: "Đề cử", input: this.host + "/reader/recent-promote"},
            {title: "Dịch", input: this.host + "/reader/recent-bns"},
            {title: "Convert", input: this.host + "/reader/recent-cv"},
            {title: "Sáng Tác", input: this.host + "/reader/recent-sangtac"},
            {title: "Hoàn thành", input: this.host + "/reader/recent-hoanthanh"}
        ]);
    }

    async genres() {
        let response = fetch(this.host + "/reader/theloai");
        if (response.ok) {
            let doc = response.html();
            let genre = [];
            doc.select("div.view-content .theloai-row a").forEach(e => genre.push({
                title: e.text(),
                input: this.host + e.attr("href"),
                script: "gen.js"
            }));
            return Response.success(genre);
        }

        return null;
    }

    async detail(url) {
        url = url.replace(/^(?:https?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n?]+)/img, this.host);

        let response = fetch(url);
        if (response.ok) {
            let doc = response.html();
            if (doc.select("title").text().includes("Đăng nhập để đọc truyện")) {
                return Response.error("Bạn cần đăng nhập hoặc tạo tài khoản mới để tiếp tục đọc truyện.");
            }
            let genres = [];
            doc.select("#theloai a").forEach(e => {
                genres.push({
                    title: e.text(),
                    input: this.host + e.attr("href"),
                    script: "gen.js"
                });
            });
            return Response.success({
                name: doc.select("h1#truyen-title").text(),
                cover: doc.select("div#anhbia img").attr("src"),
                author: doc.select("div#tacgia a").text(),
                description: doc.select("div#gioithieu .block-content").html(),
                detail: doc.select("flag").text(),
                genres: genres,
                suggests: [
                    {
                        title: "Cùng tác giả",
                        input: doc.select(".same_author-list").html(),
                        script: "suggest.js"
                    }
                ],
                host: this.host
            });
        }
        return null;
    }

    async toc(url) {
        url = url.replace(/^(?:https?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n?]+)/img, this.host);

        let response = fetch(url + "/muc-luc?page=all");
        if (response.ok) {
            let doc = response.html();
            if (doc.select("title").text().includes("Đăng nhập để đọc truyện")) {
                return Response.error("Bạn cần đăng nhập hoặc tạo tài khoản mới để tiếp tục đọc truyện.");
            }
            let list = [];
            doc.select("#mucluc-list .chuong-item a").forEach(e => list.push({
                name: e.select(".chuong-name").text(),
                url: e.attr("href"),
                host: this.host
            }));
            return Response.success(list);

        }
        return null;
    }

    async chapter(url) {
        url = url.replace(/^(?:https?:\/\/)?(?:[^@\n]+@)?(?:www\.)?([^:\/\n?]+)/img, this.host);

        let response = fetch(url);
        if (response.ok) {
            let doc = response.html();
            if (doc.select("title").text().includes("Đăng nhập để đọc truyện")) {
                return Response.error("Bạn cần đăng nhập hoặc tạo tài khoản mới để tiếp tục đọc truyện.");
            }
            let encryptedContent = doc.select("#encrypted-content").text();
            if (encryptedContent) {
                response = fetch(this.host + "/reader/api/decrypt-content.php", {
                    method: "POST",
                    body: JSON.stringify({
                        "encryptedData": encryptedContent
                    })
                });

                let json = response.json();

                return Response.success(json.content);
            }
            return Response.success(response.html().select("#noi-dung").html());
        }
        return null;
    }
}
