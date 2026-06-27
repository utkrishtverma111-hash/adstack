# Adstacks Media — Office Admin Dashboard (Flutter)

A fully responsive office dashboard built in Flutter, modeled on the
reference design you shared, lightly re-themed and re-purposed for
**Adstacks Media** office use (employees, attendance, team performance,
birthdays/anniversaries) instead of a creator/Web3 platform.

## Run it

```bash
flutter pub get
flutter run -d chrome      # web
flutter run                # connected mobile device / emulator
```

Tested breakpoints (see `lib/core/responsive.dart`):
- **Mobile** (<700px): single column, hamburger menu opens the sidebar as a drawer, search bar collapses, schedule/celebration cards stack below the chart.
- **Tablet** (700–1100px): sidebar becomes a slim icon rail, two-column cards keep their proportions but tighten.
- **Desktop/Web** (1100px+): full sidebar shown.
- **Wide desktop/web** (1500px+): the right-hand "General schedule / Birthdays / Anniversaries" rail appears alongside the main content, matching the original layout exactly.

## Structure

```
lib/
  core/colors.dart           – design tokens / palette
  core/responsive.dart       – breakpoint helpers
  models/dashboard_data.dart – mock data (swap for your API/DB)
  widgets/
    sidebar.dart             – nav + Adstacks Media logo mark
    top_bar.dart             – search, notifications, profile
    banner_card.dart         – hero "Top Rated Project" banner
    project_list.dart        – "All Projects" card + DashCard/CardHeader helpers
    top_team_card.dart       – top-performing employees table
    performance_chart_card.dart – fl_chart line graph (Pending vs Done)
    office_schedule_card.dart   – table_calendar widget
    celebration_card.dart       – birthday / anniversary cards
  screens/dashboard_screen.dart – responsive layout composition
  main.dart                     – app entry + theme
```

## Brand touch

`AdstacksLogo` (in `sidebar.dart`) is a small reusable "AS" gradient mark +
wordmark used in the sidebar header.

**Important — colors are a placeholder.** I wasn't able to extract the exact
hex values from the live Adstacks Media logo file from here (no pixel-level
image access in this environment). `core/colors.dart` currently ships a
navy-blue + coral palette chosen to suit a performance-marketing agency, with
a comment flagging the two constants (`brandPurple`, `brandPink`) to swap —
open the real logo in any color picker and drop the hex in; every widget in
the app reads from those two constants, so it's a one-file change before you
submit.

## Campaigns module (new)

Added a second nav section — **Campaigns** — modeled on what an agency like
Adstacks actually runs day to day, instead of only generic office-admin
panels:

- `models/campaign_data.dart` — per-client campaign records (channel: SEO /
  PPC / Social / Web Dev / Lead Gen, status, budget spent vs. total, ROI %,
  leads generated, a 6-point trend for the sparkline).
- `widgets/campaign_stats_row.dart` — top-line stat tiles (active campaigns,
  avg. ROI, total leads, ad spend).
- `widgets/campaign_card.dart` — per-client card with channel badge, ROI,
  mini sparkline (fl_chart), and a budget-spent progress bar.
- `screens/campaigns_screen.dart` — responsive grid (1 col mobile, 2 tablet,
  3 desktop).

Swap the mock list in `CampaignData.campaigns` for real CRM/ad-platform data
when you wire up an API.

## Next steps for production

- Replace `DashboardData` with live data (REST/GraphQL/Firestore).
- Add auth-gated routes if multiple roles (Admin/HR/Employee) need different views.
- Wire up the "Birthday/Anniversary Wishing" buttons to your notification or email service.
- Add a dark-mode toggle if needed — the palette is already split light/dark per surface.
