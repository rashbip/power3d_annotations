class Power3DAnnotationStyles {
  /// A premium glassmorphic tooltip style for annotations.
  static const String tooltip = r'''
<style>
  .power3d-annotation {
    position: absolute;
    transform: translate(-50%, -100%);
    pointer-events: auto;
    z-index: 1000;
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
    transition: opacity 0.3s ease, transform 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    opacity: 0;
    will-change: transform, opacity;
  }

  .power3d-annotation.visible {
    opacity: 1;
    transform: translate(-50%, -110%) scale(1);
  }

  .power3d-annotation.hidden {
    opacity: 0;
    transform: translate(-50%, -100%) scale(0.9);
    pointer-events: none;
  }

  .power3d-tooltip-card {
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(12px);
    -webkit-backdrop-filter: blur(12px);
    border: 1px solid rgba(255, 255, 255, 0.3);
    border-radius: 16px;
    padding: 16px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1), inset 0 0 0 1px rgba(255, 255, 255, 0.2);
    width: 280px;
    color: #1a1a1a;
  }

  .power3d-tooltip-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 8px;
  }

  .power3d-tooltip-title {
    font-weight: 700;
    font-size: 16px;
    margin: 0;
    color: #000;
  }

  .power3d-tooltip-body {
    font-size: 13px;
    line-height: 1.5;
    margin-bottom: 12px;
    color: #444;
    display: -webkit-box;
    -webkit-line-clamp: 4;
    -webkit-box-orient: vertical;
    overflow: hidden;
  }

  .power3d-tooltip-footer {
    display: flex;
    justify-content: flex-end;
  }

  .power3d-tooltip-more {
    display: inline-flex;
    align-items: center;
    font-size: 12px;
    font-weight: 600;
    color: #007AFF;
    text-decoration: none;
    transition: opacity 0.2s;
  }

  .power3d-tooltip-more:hover {
    opacity: 0.7;
  }

  .power3d-tooltip-more::after {
    content: ' →';
    margin-left: 4px;
  }

  .power3d-annotation-pin {
    width: 12px;
    height: 12px;
    background: #007AFF;
    border: 2px solid white;
    border-radius: 50%;
    position: absolute;
    bottom: -6px;
    left: 50%;
    transform: translateX(-50%);
    box-shadow: 0 0 10px rgba(0, 122, 255, 0.5);
  }

  .power3d-annotation-pin::before {
    content: '';
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    width: 24px;
    height: 24px;
    border: 2px solid #007AFF;
    border-radius: 50%;
    opacity: 0.5;
    animation: pulse 2s infinite;
  }

  @keyframes pulse {
    0% { transform: translate(-50%, -50%) scale(0.5); opacity: 0.8; }
    100% { transform: translate(-50%, -50%) scale(2); opacity: 0; }
  }

  /* Dark mode support */
  @media (prefers-color-scheme: dark) {
    .power3d-tooltip-card {
      background: rgba(30, 30, 30, 0.75);
      border-color: rgba(255, 255, 255, 0.1);
      color: #eee;
    }
    .power3d-tooltip-title { color: #fff; }
    .power3d-tooltip-body { color: #ccc; }
    .power3d-tooltip-more { color: #0A84FF; }
  }
</style>

<div class="power3d-annotation" id="annotation-{{id}}">
  <div class="power3d-tooltip-card">
    <div class="power3d-tooltip-header">
      <h3 class="power3d-tooltip-title">{{title}}</h3>
    </div>
    <div class="power3d-tooltip-body">
      {{description}}
    </div>
    <div class="power3d-tooltip-footer">
      <a href="{{more}}" target="_blank" class="power3d-tooltip-more">Learn More</a>
    </div>
  </div>
  <div class="power3d-annotation-pin"></div>
</div>
''';
}
