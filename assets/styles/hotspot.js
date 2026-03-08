/**
 * Power3D Hotspot Style (js/annotation/styles/hotspot.js)
 * Minimal dot style inspired by Sketchfab.
 */
'use strict';

window.Power3DHotspotStyle = (() => {
    function injectStyles() {
        if (document.getElementById('p3d-hotspot-style')) return;
        const style = document.createElement('style');
        style.id = 'p3d-hotspot-style';
        style.textContent = `
            .p3d-hotspot-el {
                position: absolute;
                pointer-events: auto;
                z-index: 2200;
                cursor: pointer;
            }
            .p3d-hotspot-dot {
                width: 32px;
                height: 32px;
                background: rgba(255, 255, 255, 0.4);
                border: 2px solid white;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.3s ease;
                box-shadow: 0 0 20px rgba(0,0,0,0.3);
            }
            .p3d-hotspot-inner {
                width: 12px;
                height: 12px;
                background: white;
                border-radius: 50%;
                transition: all 0.3s ease;
            }
            .p3d-hotspot-el:hover .p3d-hotspot-dot {
                transform: scale(1.15);
                background: rgba(255, 255, 255, 0.9);
            }
            .p3d-hotspot-card {
                position: absolute;
                bottom: 45px;
                left: 50%;
                transform: translateX(-50%) translateY(10px);
                background: #fff;
                color: #1a1a1a;
                border-radius: 12px;
                padding: 16px;
                width: 240px;
                box-shadow: 0 12px 32px rgba(0,0,0,0.25);
                opacity: 0;
                pointer-events: none;
                transition: all 0.3s cubic-bezier(0.18, 0.89, 0.32, 1.28);
                font-family: 'Outfit', sans-serif;
            }
            .p3d-hotspot-el.active .p3d-hotspot-card {
                opacity: 1;
                pointer-events: auto;
                transform: translateX(-50%) translateY(0);
            }
            .p3d-hotspot-el.active .p3d-hotspot-inner {
                background: #38bdf8;
                transform: scale(1.4);
            }
            .p3d-hotspot-title {
                margin: 0 0 8px 0;
                font-weight: 700;
                font-size: 16px;
            }
            .p3d-hotspot-body {
                margin: 0;
                font-size: 14px;
                line-height: 1.6;
                color: #475569;
            }
            @keyframes hotspot-pulse {
                0% { transform: scale(1); opacity: 0.8; }
                50% { transform: scale(1.5); opacity: 0.3; }
                100% { transform: scale(2.0); opacity: 0; }
            }
            .p3d-hotspot-pulse-ring {
                position: absolute;
                width: 32px;
                height: 32px;
                border: 2px solid white;
                border-radius: 50%;
                animation: hotspot-pulse 2.5s infinite;
                pointer-events: none;
            }
        `;
        document.head.appendChild(style);
    }

    function createDom(ann) {
        injectStyles();
        const el = document.createElement('div');
        el.className = 'p3d-hotspot-el';
        
        el.innerHTML = `
            <div class="p3d-hotspot-pulse-ring"></div>
            <div class="p3d-hotspot-dot">
                <div class="p3d-hotspot-inner"></div>
            </div>
            <div class="p3d-hotspot-card">
                <p class="p3d-hotspot-title">${ann.ui.title}</p>
                <div class="p3d-hotspot-body">${ann.ui.description || ''}</div>
                ${ann.ui.more ? `<a href="${ann.ui.more}" target="_blank" style="color:#38bdf8;text-decoration:none;font-size:11px;font-weight:600;display:block;margin-top:8px;">Details</a>` : ''}
            </div>
        `;

        el.onclick = (e) => {
            e.stopPropagation();
            document.querySelectorAll('.p3d-hotspot-el, .p3d-callout-el').forEach(o => {
                if(o !== el) o.classList.remove('active');
            });
            const isActive = el.classList.toggle('active');
            if (isActive && ann.camera && window.Power3DAnnotationEngine) {
                window.Power3DAnnotationEngine.flyTo(ann.camera);
            }
        };

        if (ann.isSelected) el.classList.add('active');
        return el;
    }

    return { createDom };
})();
