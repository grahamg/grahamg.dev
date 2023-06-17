build:
	jekyll build --destination=/var/www/grahamg.dev

serve:
	jekyll serve --destination=/var/www/grahamg.dev --watch --drafts

clean:
	rm -rf /var/www/grahamg.dev/*

.PHONY: build clean watch
