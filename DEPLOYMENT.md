# Deployment checklist for PulseForge (my-novel)

1. Upload the contents of /home/fadil369/my-novel to the web root on brainsait.de and brainsait.cloud (ensure directory structure preserved).
2. Configure canonical host: brainsait.de is canonical; files include <link rel="canonical"> tags already.
3. Set up HTTPS with valid certificates (Let's Encrypt recommended) and enable HSTS.
4. Option A: Have brainsait.cloud redirect to brainsait.de for SEO consolidation. Option B: Use brainsait.cloud as a mirror with hreflang/alternate links configured.
4.1 Ensure both hosts serve identical content or set up proper canonical/alternate headers.
5. Place sitemap.xml at the root and reference all volNN.html and index.html.
6. Add robots.txt to allow indexing of the site.
7. Configure caching headers for static assets (/assets/*.css) to leverage CDN caching.
8. Set up CI (GitHub Actions) to run accessibility audits (pa11y/axe) and linting on PRs.
9. Run final proofread and Arabic literary pass before publishing.
10. Monitor site after deploy for 7 days for errors, broken links, and accessibility regressions.
