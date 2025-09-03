# Tech Stack

## Context

Global tech stack defaults for Agent OS projects, overridable in project-specific `.agent-os/product/tech-stack.md`.

- App Framework: Next.js 15+
- Language: JavaScript - Node 24+
- Primary Database: PostgreSQL 17+
- ORM: Prisma
- JavaScript Framework: React latest stable
- Build Tool: Vite
- Import Strategy: Node.js modules
- Package Manager: npm
- Node Version: 24 LTS
- CSS Framework: TailwindCSS 4+
- UI Components: Custom, but use Radix primatives where helpful
- UI Installation: Via npm
- Font Provider: Google Fonts
- Font Loading: Self-hosted for performance
- Icons: ZestIcons.com
- Application Hosting: Vercel
- Hosting Region: US East
- Database Hosting: Vercel
- Database Backups: Daily automated
- Asset Storage: Amazon S3
- CDN: CloudFront
- Asset Access: Private with signed URLs
- CI/CD Platform: GitHub Actions
- CI/CD Trigger: Push to main/staging branches
- Tests: Run before deployment
- Production Environment: main branch
- Staging Environment: staging branch (if present)
